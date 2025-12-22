import 'package:spotify_dribble/features/album/domain/model/album.dart';
import 'package:spotify_dribble/features/track/domain/model/track_simplified.dart';

abstract class AlbumRepo {
  Future<Album> getAlbum({required String id});
  Future<List<Album>> getAlbums({required List<String> ids});
  Future<List<TrackSimplified>> getAlbumTracks({required String id,int? limit,int? offset});
  Future<List<Album>> getUserSavedAlbums({int? limit,int? offset,});
}