import 'package:spotify_dribble/features/playlist/domain/model/playlist_simplified.dart';

sealed class PlaylistStates {}
class PlaylistInitial extends PlaylistStates{}
class UserPlaylistLoaded extends PlaylistStates{
  final List<PlaylistSimplified> playlists;
  UserPlaylistLoaded({
    required this.playlists
  });
}
class PlaylistLoading extends PlaylistStates{}
class PlaylistError extends PlaylistStates{
  final String message;
  PlaylistError({
    required this.message
  });
}