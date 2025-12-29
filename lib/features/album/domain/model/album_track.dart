import 'package:spotify_dribble/features/artist/domain/model/artist_simplified.dart';

class AlbumTrack {
  final String id;
  final String name;
  final String uri;
  final String type;
  final int discNumber; 
  final int durationMs;
  final int trackNumber;
  final List<ArtistSimplified> artists;
  AlbumTrack({
    required this.artists,
    required this.discNumber,
    required this.durationMs,
    required this.id,
    required this.name,
    required this.trackNumber,
    required this.type,
    required this.uri,
  });
  factory AlbumTrack.fromJson(Map<String,dynamic> json){
    return AlbumTrack(
      artists: (json["artists"]as List<dynamic>).map((json)=>ArtistSimplified.fromJson(json)).toList(), 
      discNumber: json["disc_number"], 
      durationMs: json["duration_ms"], 
      id: json["id"],
      name: json["name"], 
      trackNumber: json["track_number"], 
      type: json["type"], 
      uri: json["uri"]
    );
  }
}