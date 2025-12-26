import 'package:spotify_dribble/features/artist/domain/model/artist.dart';

sealed class ArtistStates {}
class ArtistInitial extends ArtistStates{}
class ArtistLoading extends ArtistStates{}
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