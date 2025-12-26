class Owner {
  final String id;
  final String type;
  final String uri;
  final String? displayName;
  Owner({
    required this.displayName,
    required this.id,
    required this.type,
    required this.uri
  });

  factory Owner.fromJson(Map<String,dynamic> json){
    return Owner(
      displayName: json["display_name"], 
      id: json["id"], 
      type: json["type"], 
      uri: json["uri"]
    );     
  }
}