import 'package:spotify_dribble/core/player/domain/model/device.dart';
import 'package:spotify_dribble/core/player/domain/model/player_item.dart';

class PlaybackState {
  final Device device;
  final String repeatState;
  final bool shuffleState;
  final bool isPlaying;
  final int timestamp;
  final int progressMs;
  final PlayerItem? playerItem;
  PlaybackState({
    required this.device,
    required this.isPlaying,
    required this.playerItem,
    required this.progressMs,
    required this.repeatState,
    required this.shuffleState,
    required this.timestamp,
  });
  factory PlaybackState.fromJson(Map<String,dynamic> json){
    return PlaybackState(
      device: Device.fromJson(json["device"]), 
      isPlaying: json["is_playing"], 
      playerItem: PlayerItem.fromJson(json["item"]), 
      progressMs: json["progress_ms"], 
      repeatState: json["repeat_state"], 
      shuffleState: json["shuffle_state"], 
      timestamp: json["timestamp"]
    );      
  }

}