import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:spotify_dribble/core/auth/data/services/spotify_auth_manager.dart';
import 'package:spotify_dribble/core/auth/data/spotify_oauth_pkce.dart';
import 'package:spotify_dribble/core/auth/domain/model/access_token.dart';
import 'package:http/http.dart' as http;
import 'package:spotify_dribble/core/auth/domain/model/header.dart';

class ApiClient {
  final SpotifyOauthPkce spotifyOauthPkce = SpotifyOauthPkce();
  final SpotifyAuthManager spotifyAuthManager = SpotifyAuthManager(spotifyOauthPkce:SpotifyOauthPkce());
  Future<Map<String, dynamic>> _parseJson(String body) async {
    return await jsonDecode(body) as Map<String, dynamic>;
  }

  Future<T?> get<T>({required String endpoint,String? query,required T Function(Map<String, dynamic>) fromJson,int retries = 3,})async{
    int attempt = 0;
    final AccessToken accessToken = await spotifyAuthManager.getValidToken();
    while (true) {
      try {
        final Map<String, String> headers = Header(accessToken:accessToken.token).toMap();
        final Uri url = Uri(
          scheme: "https",
          host: "api.spotify.com",
          path: endpoint,
          query:query
        );
        final http.Response response = await http.get(url, headers: headers);
        switch(response.statusCode){
          case 200:
          final Map<String, dynamic> data = await compute(
          _parseJson,
          response.body,
          );
          return fromJson(data);
          case 204:
          return null;
        }
      } catch (e) {
        if(attempt>=retries)rethrow;
        await Future.delayed(Duration(seconds: 10));
        attempt++;
      }
    }
  }

  Future<void> put({required String endpoint,String? queryParameters,Map<String,String>? extraheaders ,Map<String,dynamic>? body,int retries=3})async{
    int attempt = 0;
    final AccessToken accessToken = await spotifyAuthManager.getValidToken();
    while(true){
      try{
        final Map<String,String> headers = Header(
          accessToken: accessToken.token,
          extraHeaders: extraheaders
        ).toMap();
        final Uri url = Uri(
          scheme: "https",
          host: "api.spotify.com",
          path: endpoint,
          query: queryParameters 
        );
        await http.put(url,headers:headers,body:body!=null ?jsonEncode(body):null);
        return;
      }
      catch(e){
        if(attempt>=retries)rethrow;
        await Future.delayed(Duration(seconds:10));
        attempt++;
      }
    }
  }
  Future<void> post({required String endpoint,String? queryParameters,Map<String,dynamic>? body,int retries=3})async{
    int attempt = 0;
    final AccessToken accessToken = await spotifyAuthManager.getValidToken();
    while(true){
      try{
        final Map<String,String> headers= Header(accessToken: accessToken.token).toMap();
        final Uri url = Uri(
          scheme: "https",
          host: "api.spotify.com",
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
