import 'package:spotify_dribble/features/album/model/album.dart';
import 'package:spotify_dribble/features/track/model/track.dart';

abstract class AlbumRepo {
  Future<Album> getAlbum({required String id});
  Future<Album> getAlbums({required List<String> ids});
  Future<List<Track>> getAlbumTracks({required String id,int? limit,int? offset});
  Future<List<Album>> getUserSavedAlbums({int? limit,int? offset,});
}