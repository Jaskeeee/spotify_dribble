import 'package:spotify_dribble/features/episode/domain/model/episode.dart';
import 'package:spotify_dribble/features/track/domain/model/track.dart';

class PlaylistItem {
  final Track? track;
  final Episode? episode;
  PlaylistItem({
    this.episode,
    this.track
  });
  bool get isTrack=>track!=null;
  bool get isEpisode=>episode!=null;

  static PlaylistItem? fromJson(Map<String,dynamic>? json){
    if(json==null){
      return null;
    }
    switch(json["type"]){
      case 'track':
      return PlaylistItem(
        track: Track.fromJson(json)
      );
      case 'episode':
      return PlaylistItem(
        episode: Episode.fromJson(json)
      );
      default:
      return null;
    }
  }
}