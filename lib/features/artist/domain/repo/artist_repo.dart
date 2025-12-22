import 'package:spotify_dribble/features/album/domain/model/album.dart';
import 'package:spotify_dribble/features/artist/domain/model/artist.dart';

abstract class ArtistRepo {
  Future<Artist> getArtist({required String id});
  Future<List<Album>> getArtistAlbums({required String id}); 
}