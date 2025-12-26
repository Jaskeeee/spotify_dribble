import 'package:spotify_dribble/core/models/image_model.dart';

class Artist { 
  final String id;
  final String name;
  final String uri;
  final List<ImageModel> images;
  final String type;
  final int followers;

  Artist({
    required this.id,
    required this.name,
    required this.followers,
    required this.images,
    required this.uri,
    required this.type
  });

  factory Artist.fromJson(Map<String,dynamic> json){
    return Artist(
      id: json["id"], 
      name: json["name"], 
      uri: json["uri"],
      images: (json["images"] as List<dynamic>).map((json)=>ImageModel.fromJson(json)).toList(), 
      followers: json["followers"]["total"], 
      type: json["type"]
    );
  }
}