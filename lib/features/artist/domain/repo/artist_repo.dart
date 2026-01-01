import 'package:spotify_dribble/features/album/domain/model/album_simplified.dart';
import 'package:spotify_dribble/features/artist/domain/model/artist.dart';

abstract class ArtistRepo {
  Future<Artist> getArtist({required String id});
  Future<List<AlbumSimplified>> getArtistAlbums({required String id}); 
}