
import 'package:spotify_dribble/core/auth/domain/model/spotify_user.dart';
import 'package:spotify_dribble/core/player/domain/model/player_item.dart';
import 'package:spotify_dribble/features/album/domain/model/album.dart';
import 'package:spotify_dribble/features/track/domain/model/track_album.dart';

class PageData {
  final Album? album;
  final SpotifyUser? user;
  final PlayerItem? playerItem;
  final TrackAlbum? trackAlbum;
  PageData({
    this.album,
    this.user,
    this.playerItem,
    this.trackAlbum,
  });
}