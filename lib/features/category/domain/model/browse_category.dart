import 'package:spotify_dribble/core/models/image_model.dart';

class BrowseCategory {
  final String id;
  final String name;
  final String href;
  final List<ImageModel> icons;
  BrowseCategory({
    required this.id,
    required this.name,
    required this.href,
    required this.icons
  });
  factory BrowseCategory.fromJson(Map<String,dynamic> json){
    return BrowseCategory(
      id: json["id"], 
      name: json["name"], 
      href: json["href"], 
      icons: (json["icons"] as List<dynamic>).map((json)=>ImageModel.fromJson(json)).toList()
    );
  }
}