import 'package:spotify_dribble/core/auth/domain/model/spotify_user.dart';

abstract class UserRepo {
  Future<SpotifyUser?>getCurrentUserProfile();
  Future<SpotifyUser?>getUserProfile(String uid);
  Future<void>followPlayList(String playlistId);
  Future<void>unfollowPlaylist(String playlistId);
}