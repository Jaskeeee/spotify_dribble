class ImageModel {
  final String imageUrl;
  final int? height;
  final int? width;
  ImageModel({
    required this.imageUrl,
    required this.height,
    required this.width
  });
  
  factory ImageModel.fromJson(Map<String,dynamic> json){
    return ImageModel(
      imageUrl: json["url"], 
      height: json["height"], 
      width: json["width"]
    );
  }
}