import 'package:spotify_dribble/features/album/domain/model/album_simplified.dart';
import 'package:spotify_dribble/features/artist/domain/model/artist.dart';
import 'package:spotify_dribble/features/playlist/domain/model/playlist_simplified.dart';
import 'package:spotify_dribble/features/track/domain/model/track.dart';

class SearchItem {
  final List<Track> tracks;
  final List<AlbumSimplified> albums;
  final List<Artist> artists;
  final List<PlaylistSimplified> playlists;
  SearchItem({
    required this.albums,
    required this.artists,
    required this.playlists,
    required this.tracks,
  });

  factory SearchItem.fromJson(Map<String, dynamic> json) {
    List<T> mapList<T>(dynamic items,T Function(Map<String, dynamic>)fromJson,){
      if (items == null) return [];
      return (items as List)
          .where((e) => e != null)
          .map((e) => fromJson(e as Map<String, dynamic>))
          .toList();
    }

    return SearchItem(
      albums: mapList(
        json["albums"]?["items"],
        (e) => AlbumSimplified.fromJson(e),
      ),
      artists: mapList(json["artists"]?["items"], (e) => Artist.fromJson(e)),
      playlists: mapList(
        json["playlists"]?["items"],
        (e) => PlaylistSimplified.fromJson(e),
      ),
      tracks: mapList(json["tracks"]?["items"], (e) => Track.fromJson(e)),
    );
  }
}
