import 'package:spotify_dribble/features/artist/domain/model/artist_simplified.dart';

class TrackSimplified {
  final String id;
  final String name;
  final String uri;
  final String type;
  final int discNumber;
  final int durationMs;
  final bool explicit;
  final int trackNumber;
  final List<ArtistSimplified> artists;

  TrackSimplified({
    required this.id,
    required this.name,
    required this.uri,
    required this.type,
    required this.artists,
    required this.discNumber,
    required this.durationMs,
    required this.explicit,
    required this.trackNumber
  });

  factory TrackSimplified.fromJson(Map<String,dynamic> json){
    return TrackSimplified(
      id: json["id"], 
      name: json["name"], 
      uri: json["uri"], 
      artists: (json["artists"] as List<dynamic>).map((json)=>ArtistSimplified.fromJson(json)).toList(), 
      discNumber: json["disc_number"], 
      durationMs: json["duration_ms"], 
      explicit: json["explicit"], 
      trackNumber: json["track_number"],
      type:json["type"]
    );
  }
}