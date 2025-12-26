import 'package:spotify_dribble/features/album/domain/model/album.dart';
import 'package:spotify_dribble/features/track/domain/model/track_simplified.dart';

sealed class AlbumStates {}
class AlbumInitial extends AlbumStates{}
class AlbumError extends AlbumStates{
  final String message;
  AlbumError({required this.message});
}
class UserAlbumLoaded extends AlbumStates{
  final List<Album> albums;
  UserAlbumLoaded({required this.albums});
}
class AlbumTracksLoaded extends AlbumStates{
  final List<TrackSimplified> tracks;
  AlbumTracksLoaded({required this.tracks});
}
class AlbumLoading extends AlbumStates{}