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
      if(expiresIn==null){
        await spotifyOauthPkce.requestUserAuthorization();
        final AccessToken accessToken = await spotifyOauthPkce.requestAccessToken();
        return accessToken;
      }
      if(DateTime.now().isAfter(DateTime.parse(expiresIn))){
        final AccessToken accessToken = await spotifyOauthPkce.refreshAccessToken();   
        return accessToken;
      }else{
        final String? accessToken = await _secureStorage.read(key:"access_token");
        final String? refreshToken = await _secureStorage.read(key: "refresh_token");
        final String? newExpiresIn = await _secureStorage.read(key:"expires_in"); 
        return AccessToken(
          token: accessToken!, 
          refreshToken: refreshToken!, 
          expiresIn: DateTime.parse(newExpiresIn!)
        );
      }
    }catch(e){
      throw SpotifyAuthError(message:e.toString());
    }
  }
}