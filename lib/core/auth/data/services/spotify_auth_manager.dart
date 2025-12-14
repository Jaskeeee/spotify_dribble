import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:spotify_dribble/core/auth/data/spotify_oauth_pkce.dart';
import 'package:spotify_dribble/core/auth/domain/model/access_token.dart';
import 'package:spotify_dribble/core/error/spotify_error.dart';

class SpotifyAuthManager {
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  final SpotifyOauthPkce spotifyOauthPkce;
  SpotifyAuthManager({
    required this.spotifyOauthPkce
  });
  Future<AccessToken> getValidToken()async{
    try{
      final String? expiresIn = await _secureStorage.read(key: "expires_in");
      if(DateTime.now().isAfter(DateTime.parse(expiresIn!))){
        final AccessToken? accessToken = await spotifyOauthPkce.refreshAccessToken();   
        if(accessToken!=null){
          return accessToken;
        }else{
          await spotifyOauthPkce.requestUserAuthorization();
          return await getValidToken();
        }
      }else{
        final String? accessToken = await _secureStorage.read(key:"access_token");
        final String? refreshToken = await _secureStorage.read(key: "refresh_token");
        return AccessToken(
          token: accessToken!, 
          refreshToken: refreshToken!, 
          expiresIn: DateTime.parse(expiresIn)
        );
      }
    }catch(e){
      throw SpotifyAuthError(message:e.toString());
    }
  }
}