import 'package:spotify_dribble/core/auth/domain/model/spotify_user.dart';
import 'package:spotify_dribble/features/artist/domain/model/artist.dart';

abstract class UserRepo {
  Future<SpotifyUser?>getCurrentUserProfile();
  Future<SpotifyUser?>getUserProfile(String uid);
  Future<void>followPlayList(String playlistId);
  Future<void>unfollowPlaylist(String playlistId);
  Future<List<Artist>>getFollowedArtists({int? limit});
}