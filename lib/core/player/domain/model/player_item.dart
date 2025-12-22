import 'package:spotify_dribble/features/episode/domain/model/episode.dart';
import 'package:spotify_dribble/features/track/domain/model/track.dart';
class PlayerItem {
  final Track? track;
  final Episode? episode;
  PlayerItem({
    this.episode,
    this.track
  });
  bool get isTrack=>track!=null;
  bool get isEpisode=>episode!=null;

  static PlayerItem? fromJson(Map<String,dynamic>? json){
    if(json==null){
      return null;
    }
    switch(json["type"]){
      case 'track':
      return PlayerItem(
        track: Track.fromJson(json)
      );
      case 'episode':
      return PlayerItem(
        episode: Episode.fromJson(json)
      );
      default:
      return null;
    }
  }
}