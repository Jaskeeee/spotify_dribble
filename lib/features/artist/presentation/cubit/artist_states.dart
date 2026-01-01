import 'package:spotify_dribble/features/album/domain/model/album_simplified.dart';
import 'package:spotify_dribble/features/artist/domain/model/artist.dart';

sealed class ArtistStates {}
class ArtistInitial extends ArtistStates{}
class ArtistLoading extends ArtistStates{}
class ArtistAlbumLoaded extends ArtistStates{
  final List<AlbumSimplified> albums;
  ArtistAlbumLoaded({
    required this.albums
  });
}
class ArtistLoaded extends ArtistStates{
  final Artist artist;
  ArtistLoaded({
    required this.artist
  });
}
class ArtistError extends ArtistStates{
  final String message;
  ArtistError({
    required this.message
  });
}