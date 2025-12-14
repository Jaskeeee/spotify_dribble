import 'package:spotify_dribble/core/auth/domain/model/access_token.dart';

abstract class AuthRepo{
  Future<AccessToken?> refreshAccessToken();
  Future<void> requestUserAuthorization();
  Future<AccessToken?> requestAccessToken();
  Future<void> logOut();
}