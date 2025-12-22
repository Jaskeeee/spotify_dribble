class AlbumSimplified {
  final String id;
  final String name;
  final String uri;
  AlbumSimplified({
    required this.id,
    required this.name,
    required this.uri
  });
  
  factory AlbumSimplified.fromJson(Map<String,dynamic> json){
    return AlbumSimplified(
      id: json["id"], 
      name: json["name"], 
      uri: json["uri"]
    );
  }
}