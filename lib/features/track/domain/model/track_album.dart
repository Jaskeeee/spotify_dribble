// i know this is a bit confusing
// but the problem here is that if you want to access the album's tracks through the album modal
// you cannot use the Track modal you've already defined, because the already defined track modal 
// has an "Album" key in it, which is useful in other areas, but not when accessing the album form the track

import 'package:spotify_dribble/core/models/image_model.dart';
import 'package:spotify_dribble/features/artist/domain/model/artist_simplified.dart';

class TrackAlbum {
  final String id;
  final String name;
  final List<ImageModel> images;
  final String type;
  final String uri;
  final String albumType;
  final int totalTracks;
  final List<ArtistSimplified> artists;

  TrackAlbum({
    required this.albumType,
    required this.artists,
    required this.id,
    required this.images,
    required this.name,
    required this.totalTracks,
    required this.type,
    required this.uri
  });

  factory TrackAlbum.fromJson(Map<String,dynamic> json){
    return TrackAlbum(
      albumType: json["album_type"], 
      artists: (json["artists"] as List<dynamic>).map((json)=>ArtistSimplified.fromJson(json)).toList(), 
      id: json["id"], 
      images: (json["images"] as List<dynamic>).map((json)=>ImageModel.fromJson(json)).toList(), 
      name: json["name"], 
      totalTracks: json["total_tracks"], 
      type: json["type"], 
      uri: json["uri"]
    );
  }

}
