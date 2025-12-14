import 'package:spotify_dribble/core/models/image_model.dart';
import 'package:spotify_dribble/features/artist/model/artist_simplified.dart';

class Album {
  final String id;
  final int totalTracks;
  final String albumType;
  final String name;
  final String type;
  final List<ImageModel> images;
  final List<ArtistSimplified> artists;
  final DateTime releaseDate;
  final String releaseDatePrecision;
  final String uri;
  Album({
    required this.id,
    required this.name,
    required this.albumType,
    required this.images,
    required this.releaseDate,
    required this.uri,
    required this.type,
    required this.releaseDatePrecision,
    required this.totalTracks,
    required this.artists
  });
  factory Album.fromJson(Map<String,dynamic> json){
    return Album(
      id: json["id"], 
      name: json["name"], 
      albumType: json["album_type"], 
      images: (json["images"] as List<dynamic>).map((json)=>ImageModel.fromJson(json)).toList(), 
      releaseDate:DateTime.parse(json["release_date"]), 
      uri: json["uri"], 
      type: json["type"],
      releaseDatePrecision: json["release_date_precision"], 
      totalTracks:json["total_tracks"], 
      artists: (json["artists"] as List<dynamic>).map((json)=>ArtistSimplified.fromJson(json)).toList()
    );  
  }
}