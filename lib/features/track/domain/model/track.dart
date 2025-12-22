import 'package:spotify_dribble/features/album/domain/model/album.dart';
import 'package:spotify_dribble/features/artist/domain/model/artist_simplified.dart';

class Track {
  final String id;
  final String name;
  final String uri;
  final String type;
  final int discNumber;
  final int durationMs;
  final bool explicit;
  final int trackNumber;
  final List<ArtistSimplified> artists;
  final Album album;

  Track({
    required this.id,
    required this.album,
    required this.artists,
    required this.discNumber,
    required this.durationMs,
    required this.explicit,
    required this.name,
    required this.trackNumber,
    required this.type,
    required this.uri
  });

  factory Track.fromJson(Map<String,dynamic> json){
    return Track(
      id: json["id"], 
      album: Album.fromJson(json["album"]), 
      artists: (json["artists"] as List<dynamic>).map((json)=>ArtistSimplified.fromJson(json)).toList(), 
      discNumber: json["disc_number"], 
      durationMs: json["duration_ms"], 
      explicit: json["explicit"], 
      name: json["name"], 
      trackNumber: json["track_number"], 
      type: json["type"], 
      uri: json["uri"]
    );
  }


}