import 'package:spotify_dribble/features/artist/domain/model/artist.dart';
import 'package:spotify_dribble/features/track/model/track.dart';

class TopItem {
  final Artist? artist;
  final Track? track;
  TopItem({
    this.artist,
    this.track
  });
  bool get isTrack=>track!=null;
  bool get isArtist=>artist!=null;

  static TopItem? fromJson(Map<String,dynamic>? json){
    if(json==null){
      return null;
    }
    switch(json["type"]){
      case 'track':
      return TopItem(
        track: Track.fromJson(json)
      );
      case 'artist':
      return TopItem(
        artist: Artist.fromJson(json)
      );
      default:
      return null;
    }
  }
}