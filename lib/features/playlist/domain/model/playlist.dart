import 'package:spotify_dribble/core/models/image_model.dart';
import 'package:spotify_dribble/features/playlist/domain/model/owner.dart';
import 'package:spotify_dribble/features/playlist/domain/model/playlist_item.dart';

class Playlist {
  final String id;
  final String name;
  final String type;
  final String uri;
  final bool collaborative;
  final bool public;
  final String? description;
  final List<ImageModel> images;
  final Owner owner;
  final List<PlaylistItem?> playlistItem;
  
  Playlist({
    required this.id,
    required this.name,
    required this.uri,
    required this.type,
    required this.public,
    required this.images,
    required this.owner,
    required this.collaborative,
    required this.description,
    required this.playlistItem
  });

  factory Playlist.fromJson(Map<String,dynamic> json){
    return Playlist(
      id: json["id"], 
      name: json["name"], 
      uri: json["uri"],
      type: json["type"], 
      public: json["public"], 
      images: (json["images"] as List<dynamic>).map((json)=>ImageModel.fromJson(json)).toList(), 
      owner: Owner.fromJson(json["owner"]), 
      collaborative: json["collaborative"], 
      description: json["descritption"], 
      playlistItem: (json["tracks"]["items"] as List<dynamic>).map((json)=>PlaylistItem.fromJson(json["track"])).toList()
    );
  }



}