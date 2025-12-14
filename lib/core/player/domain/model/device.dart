class Device {
  final String id;
  final bool isActive;
  final bool isPrivateSession;
  final String name;
  final int volumePercent;
  final bool supportsVolume;

  Device({
    required this.id,
    required this.name,
    required this.isActive,
    required this.isPrivateSession,
    required this.supportsVolume,
    required this.volumePercent
  });

  factory Device.fromJson(Map<String,dynamic> json){
    return Device(
      id: json["id"], 
      name: json["name"], 
      isActive: json["is_active"], 
      isPrivateSession: json["is_private_session"], 
      supportsVolume: json["supports_volume"], 
      volumePercent: json["volume_percent"]
    );   
  }

}