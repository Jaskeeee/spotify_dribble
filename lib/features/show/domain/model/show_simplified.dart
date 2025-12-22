import 'package:spotify_dribble/core/models/image_model.dart';

class ShowSimplified {
  final String id;
  final String name;
  final String uri;
  final String type;
  final String publisher;
  final List<ImageModel> images;
  final String description;
  final bool explicit;
  final int totalEpisodes;

  ShowSimplified({
    required this.id,
    required this.name,
    required this.uri,
    required this.type,
    required this.publisher,
    required this.images,
    required this.description,
    required this.explicit,
    required this.totalEpisodes
  });

  factory ShowSimplified.fromJson(Map<String,dynamic> json){
    return ShowSimplified(
      id: json["id"], 
      name: json["name"], 
      uri: json["uri"], 
      type: json["type"], 
      publisher: json["publisher"], 
      images: (json["images"] as List<dynamic>).map((json)=>ImageModel.fromJson(json)).toList(), 
      description: json["description"], 
      explicit: json["explicit"], 
      totalEpisodes: json["total_episodes"]
    );
  }

}