import 'package:spotify_dribble/core/models/image_model.dart';

class SpotifyUser{
  final String id;
  final String displayName;
  final String email;
  final int followers;
  final List<ImageModel> profileImage;

  SpotifyUser({
    required this.displayName,
    required this.email,
    required this.followers,
    required this.id,
    required this.profileImage,
  });

  factory SpotifyUser.fromJson(Map<String,dynamic> json){
    return SpotifyUser(
      displayName: json["display_name"], 
      email: json["email"], 
      followers: json["followers"]["total"], 
      id: json["id"], 
      profileImage: (json["images"] as List<dynamic>).map(
        (imagejson)=>ImageModel.fromJson(imagejson as Map<String,dynamic>)
      ).toList()
    );     
  }
}