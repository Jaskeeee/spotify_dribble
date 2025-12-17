import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:spotify_dribble/core/auth/data/services/spotify_auth_manager.dart';
import 'package:spotify_dribble/core/auth/data/spotify_oauth_pkce.dart';
import 'package:spotify_dribble/core/auth/domain/model/access_token.dart';
import 'package:http/http.dart' as http;
import 'package:spotify_dribble/core/auth/domain/model/header.dart';
import 'package:spotify_dribble/core/constants/api_constants.dart';
import 'package:spotify_dribble/core/error/spotify_error.dart';

class ApiClient {
  final SpotifyOauthPkce spotifyOauthPkce = SpotifyOauthPkce();
  final SpotifyAuthManager spotifyAuthManager = SpotifyAuthManager(spotifyOauthPkce:SpotifyOauthPkce());
  Future<Map<String, dynamic>> _parseJson(String body) async {
    return await jsonDecode(body) as Map<String, dynamic>;
  }

  Future<T> retry<T>(Future<T> Function() action,{int retries=3,Duration delay=const Duration(seconds:3)})async{
    late Object lastError;
    for(int attempt=0;attempt<=retries;attempt++){
      try{
        return await action();
      }on SpotifyRateLimitError catch(e){
        lastError=e;
        await Future.delayed(Duration(seconds:e.retryAfter));
      }
      catch(e){
        lastError=e;
        if(attempt==retries)break;
        await Future.delayed(delay*attempt);
      }
    }
    throw lastError;
  }

  Future<T?> get<T>({required String endpoint,String? query,Map<String,dynamic>? queryParameters,required T Function(Map<String, dynamic>) fromJson,int retries = 3,})async{    

    return retry(()async{
      final AccessToken accessToken = await spotifyAuthManager.getValidToken();
      final Map<String,String> header = Header(accessToken: accessToken.token).toMap();
      final url = Uri(
        scheme: "https",
        host: baseApiUrl,
        path: endpoint,
        query: query
      );
      final response = await http.get(url,headers:header); 
      if(response.statusCode==204){
        return null;
      }
      if(response.statusCode==429){
        final retryAfter = int.tryParse(response.headers['retry-after']??'1')??1;
        SpotifyRateLimitError(retryAfter: retryAfter,message:response.body);
      }
      if(response.statusCode<200||response.statusCode>=300){
        throw HttpException(response.body);
      }
      final data = await compute(_parseJson,response.body);
      return fromJson(data);
    });
  }

  Future<void> put({required String endpoint,String? queryParameters,Map<String,String>? extraheaders ,Map<String,dynamic>? body,int retries=3})async{
    return retry(()async{
      final AccessToken accessToken = await spotifyAuthManager.getValidToken();
      final Map<String,String> header = Header(accessToken: accessToken.token,extraHeaders:extraheaders).toMap();
      final url = Uri(
        scheme: "https",
        host: baseApiUrl,
        path: endpoint,
        query: queryParameters
      );
      final response = await http.put(url,headers:header,body: body!=null?jsonEncode(body):null); 
      if(response.statusCode==204){
        
      }
      if(response.statusCode==429){
        final retryAfter = int.tryParse(response.headers['retry-after']??'1')??1;
        SpotifyRateLimitError(retryAfter: retryAfter,message:response.body);
      }
      if(response.statusCode<200||response.statusCode>=300){
        throw HttpException(response.body);
      }
    });
  }
  Future<void> post({required String endpoint,String? queryParameters,Map<String,dynamic>? body,int retries=3})async{
    int attempt = 0;
    final AccessToken accessToken = await spotifyAuthManager.getValidToken();
    while(true){
      try{
        final Map<String,String> headers= Header(accessToken: accessToken.token).toMap();
        final Uri url = Uri(
          scheme: "https",
          host: baseApiUrl,
          path: endpoint,
          query: queryParameters
        );
        await http.post(
          url,
          headers: headers,
          body: body!=null ?jsonEncode(body): null
        );
        return;
      }
      catch(e){
        if(attempt>=retries)rethrow;
        await Future.delayed(Duration(seconds: 10));
        attempt++;
      }
    }
  }
}
