import 'package:spotify_dribble/features/playlist/model/playlist.dart';
import 'package:spotify_dribble/features/playlist/model/playlist_simplified.dart';

abstract class PlaylistRepo {
  Future<Playlist> getPlayList({required String playlistId});
  Future<List<PlaylistSimplified>>getUserPlaylists({required String userId,int? limit,int? offset});
}