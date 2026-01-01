import 'package:spotify_dribble/core/models/image_model.dart';
import 'package:spotify_dribble/features/artist/domain/model/artist_simplified.dart';

class AlbumSimplified {
  final String id;
  final String name;
  final String uri;
  final String type;
  final String releaseDate;
  final int totalTracks;
  final List<ImageModel> images;
  final List<ArtistSimplified> artists;
  AlbumSimplified({
    required this.id,
    required this.name,
    required this.uri,
    required this.images,
    required this.totalTracks,
    required this.type,
    required this.releaseDate,
    required this.artists,
  });
  
  factory AlbumSimplified.fromJson(Map<String,dynamic> json){
    return AlbumSimplified(
      id: json["id"], 
      name: json["name"], 
      uri: json["uri"],
      images: (json["images"] as List<dynamic>).map((json)=>ImageModel.fromJson(json)).toList(),
      totalTracks: json["total_tracks"],
      type: json["type"],
      releaseDate: json["release_date"],
      artists: (json["artists"]as List<dynamic>).map((json)=>ArtistSimplified.fromJson(json)).toList()
    );
  }
}