import 'package:spotify_dribble/core/models/image_model.dart';
import 'package:spotify_dribble/features/episode/domain/model/episodes.dart';

class Show {
  final String id;
  final String name;
  final String type;
  final String publisher;
  final String uri;
  final String description;
  final int totalEpisodes;
  final bool explicit;
  final List<ImageModel> images;
  final Episodes episodes;
  Show({
    required this.id,
    required this.name,
    required this.type,
    required this.uri,
    required this.publisher,
    required this.description,
    required this.totalEpisodes,
    required this.images,
    required this.episodes,
    required this.explicit
  });

  factory Show.fromJson(Map<String,dynamic> json){
    return Show(
      id: json["id"], 
      name: json["name"], 
      type: json["type"], 
      uri: json["uri"], 
      description: json["description"], 
      totalEpisodes: json["total_episodes"], 
      publisher: json["publisher"],
      images: (json["images"] as List<dynamic>).map((json)=>ImageModel.fromJson(json)).toList(), 
      episodes: json["episodes"], 
      explicit: json["explicit"]
    );
  }

}