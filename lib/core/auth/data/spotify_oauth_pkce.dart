import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:spotify_dribble/core/auth/domain/model/access_token.dart';
import 'package:spotify_dribble/core/auth/domain/repo/auth_repo.dart';
import 'package:spotify_dribble/core/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:spotify_dribble/core/error/spotify_error.dart';
import 'package:url_launcher/url_launcher.dart';

class SpotifyOauthPkce implements AuthRepo{
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  final HttpClient client = HttpClient();
  String generateCodeVerifier(int length) {
    final Random random = Random.secure();
    return List.generate(
      length,
      (index) => possibleCharSet[random.nextInt(possibleCharSet.length)],
    ).join();
  }

  String codeChallenge(String codeVerifier) {
    final Uint8List utf8enoded = utf8.encode(codeVerifier);
    final Digest digest = sha256.convert(utf8enoded);
    final String base64encoded = base64Url
        .encode(digest.bytes)
        .replaceAll("=", '');
    return base64encoded;
  }

  @override
  Future<AccessToken>refreshAccessToken()async{
    try{
      final String? refreshToken = await _storage.read(key: "refresh_token");
      final Map<String,String> queryParameters = {
        "grant_type":"refresh_token",
        "refresh_token":refreshToken!,
        "client_id":dotenv.get("SPOTIFY_CLIENT_ID"),
      };
      final Uri refreshUrl = Uri(
        scheme: "https",
        host: "accounts.spotify.com",
        path: "/api/token",
      );
      final http.Response response = await http.post(
        refreshUrl,
        headers: contentHeader,
        body: queryParameters,
      );
      switch(response.statusCode){
        case 200:
        final responseBody = jsonDecode(response.body);
        final String accessToken = responseBody["access_token"];
        final String refreshToken = responseBody["refresh_token"];
        final int tokenExpiry = (responseBody["expires_in"]-300);
        final DateTime dateTime = DateTime.now();
        final DateTime expiresIn = dateTime.add(Duration(seconds: tokenExpiry));
        await _storage.write(key: "access_token", value:accessToken);
        await _storage.write(key: "refresh_token", value: refreshToken);
        await _storage.write(key: "expires_in", value: expiresIn.toString());
        return AccessToken(
          token: accessToken, 
          refreshToken: refreshToken, 
          expiresIn: expiresIn
        );
        case 400:
        throw SpotifyAuthError(message:response.body,statusCode:response.statusCode);
        case 401:
        throw SpotifyAuthError(message:response.body,statusCode:response.statusCode);
        case 403:
        throw SpotifyAuthError(message:response.body,statusCode:response.statusCode);
        case 404:
        throw SpotifyAuthError(message:response.body,statusCode:response.statusCode);
        case 408:
        throw SpotifyAuthError(message:response.body,statusCode:response.statusCode);
        case 429:
        throw SpotifyAuthError(message:response.body,statusCode:response.statusCode);
        case 500:
        throw SpotifyAuthError(message:response.body,statusCode:response.statusCode);
        case 502:
        throw SpotifyAuthError(message:response.body,statusCode:response.statusCode);
        case 503:
        throw SpotifyAuthError(message:response.body,statusCode:response.statusCode);
        case 504:
        throw SpotifyAuthError(message:response.body,statusCode:response.statusCode);
        default:
        throw SpotifyAuthError(message: "Unkown Error Occurred while refreshing access Token");
      }
    }catch(e){
      throw SpotifyError(message:e.toString());
    }
  }

  @override
  Future<void> requestUserAuthorization({int port = 8888,Duration timeout = const Duration(minutes: 2)}) async {
    final String codeVerifier = generateCodeVerifier(64);
    await _storage.write(key: "code_verifier", value:codeVerifier);
    final Map<String, String> params = {
      "response_type": "code",
      "client_id": dotenv.get("SPOTIFY_CLIENT_ID"),
      "scope": scopes.join(' '),
      "code_challenge_method": "S256",
      "code_challenge": codeChallenge(codeVerifier),
      "redirect_uri": dotenv.get("SPOTIFY_REDIRECT_URI"),
    };
    final Uri authUrl = Uri(
      scheme: "https",
      host: "accounts.spotify.com",
      path: '/authorize',
      queryParameters: params,
    );
    if(!await launchUrl(authUrl)){
      throw SpotifyError(message: "Couldn't Launch Default browser for Authentication");
    }
    final HttpServer server = await HttpServer.bind(
      InternetAddress.loopbackIPv4,
      port,
    );
    final Completer completer = Completer<String?>();
    final Timer timer = Timer(timeout, () {
      if (!completer.isCompleted) {
        completer.completeError("AUTH TIMEOUT:Error waiting for auth callback");
        server.close(force: true);
      }
    });
    server.listen((HttpRequest request) async {
      try {
        final Uri uri = request.uri;
        if (uri.path == "/callback" && !uri.queryParameters.containsKey("error")) {
          final code = uri.queryParameters["code"];
          request.response.statusCode = 200;
          request.response.headers.contentType = ContentType.html;
          final File file = File("lib/core/html/callback_page.html");
          await file.openRead().pipe(request.response);
          if (!completer.isCompleted) {
            completer.complete(code);
            timer.cancel();
            await Future.delayed(Duration(seconds:10));
            await server.close(force:true);
          }
        } else {
          if(uri.queryParameters.containsValue("access_denied")){
            request.response.statusCode=302;
            request.response.headers.contentType=ContentType.html;
            final File file = File("lib/core/html/access_denied.html");
            await file.openRead().pipe(request.response);
            throw SpotifyAuthError(message:"Access Denied",statusCode:request.response.statusCode,);
          }
          request.response.statusCode = 404;
          await request.response.close();
          server.close(force: true);
          throw SpotifyAuthError(message: "Failed User Authorization");
        }
      } catch (e) {
        if(!completer.isCompleted){
          completer.completeError(e);
          timer.cancel();
        }
        server.close(force: true);
      }
    },onError:(e){
      if(!completer.isCompleted){
        completer.completeError(e);
        timer.cancel();
      }
      server.close(force: true);
    }
    );
    final String? authCode = await completer.future;
    await _storage.write(key: "auth_code", value:authCode);
  }

  @override
  Future<AccessToken>requestAccessToken()async{
    try{
      final String? codeVerifier = await _storage.read(key: "code_verifier");
      final String? authCode = await _storage.read(key: "auth_code");
      final Map<String,String> queryParameters = {
        "client_id":dotenv.get("SPOTIFY_CLIENT_ID"),
        "grant_type":"authorization_code",
        "code":authCode!,
        "redirect_uri":dotenv.get("SPOTIFY_REDIRECT_URI"),
        "code_verifier":codeVerifier!
      };
      final Uri accessTokenUri = Uri(
        scheme: "https",
        host: "accounts.spotify.com",
        path: "/api/token",
      );
      final http.Response response = await http.post(
        accessTokenUri,
        headers:contentHeader,
        body: queryParameters 
      );
      switch(response.statusCode){
        case 200:
        final responseBody = jsonDecode(response.body);
        final String accessToken = responseBody["access_token"];
        final String refreshToken = responseBody["refresh_token"];
        final int tokenExpiry = (responseBody["expires_in"]-300);
        final DateTime dateTime = DateTime.now();
        final DateTime expiresIn = dateTime.add(Duration(seconds: tokenExpiry));
        await _storage.write(key: "access_token", value:accessToken);
        await _storage.write(key: "refresh_token", value: refreshToken);
        await _storage.write(key: "expires_in", value: expiresIn.toString());
        return AccessToken(
          token: accessToken, 
          refreshToken: refreshToken, 
          expiresIn: expiresIn
        );
        case 400:
        throw SpotifyAuthError(message:response.body,statusCode:response.statusCode);
        case 401:
        throw SpotifyAuthError(message:response.body,statusCode:response.statusCode);
        case 403:
        throw SpotifyAuthError(message:response.body,statusCode:response.statusCode);
        case 404:
        throw SpotifyAuthError(message:response.body,statusCode:response.statusCode);
        case 408:
        throw SpotifyAuthError(message:response.body,statusCode:response.statusCode);
        case 429:
        throw SpotifyAuthError(message:response.body,statusCode:response.statusCode);
        case 500:
        throw SpotifyAuthError(message:response.body,statusCode:response.statusCode);
        case 502:
        throw SpotifyAuthError(message:response.body,statusCode:response.statusCode);
        case 503:
        throw SpotifyAuthError(message:response.body,statusCode:response.statusCode);
        case 504:
        throw SpotifyAuthError(message:response.body,statusCode:response.statusCode);
        default:
        throw SpotifyAuthError(message: "Unkown Error Occurred while requesting access Token");
      }

    }
    catch(e){
      throw SpotifyError(message: e.toString());
    }
  }
  @override
  Future<void> logOut()async{
    try{
      await _storage.delete(key: "access_token");
      await _storage.delete(key: "refresh_token");
      await _storage.delete(key: "expires_in");
    }
    catch(e){
      throw SpotifyError(message: e.toString());
    }
  }
}
