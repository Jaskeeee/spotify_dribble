import 'package:spotify_dribble/core/models/image_model.dart';
import 'package:spotify_dribble/features/playlist/domain/model/owner.dart';

class PlaylistSimplified {
  final String id;
  final String name;
  final Owner owner;
  final String uri;
  final String type;
  final int total;
  final List<ImageModel> images;
  final bool public;
  final bool collaborative;
  final String? description;
  PlaylistSimplified({
    required this.id,
    required this.name,
    required this.owner,
    required this.uri,
    required this.total,
    required this.type,
    required this.collaborative,
    required this.description,
    required this.images,
    required this.public
  });
  
  factory PlaylistSimplified.fromJson(Map<String,dynamic> json){
    return PlaylistSimplified(
      id: json["id"], 
      name: json["name"], 
      owner: Owner.fromJson(json["owner"]), 
      uri: json["uri"], 
      total: json["tracks"]["total"], 
      type: json["type"], 
      collaborative: json["collaborative"], 
      description: json["description"], 
      images: json["images"]!=null?(json["images"] as List<dynamic>).map((json)=>ImageModel.fromJson(json)).toList():[], 
      public: json["public"]
    );
  }
}