class ArtistSimplified {
  final String id;
  final String name;
  final String uri;

  ArtistSimplified({
    required this.id,
    required this.name,
    required this.uri
  });

  factory ArtistSimplified.fromJson(Map<String,dynamic> json){
    return ArtistSimplified(
      id: json["id"], 
      name: json["name"], 
      uri: json["uri"]
    );
  }
}