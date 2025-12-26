
import 'package:spotify_dribble/core/auth/domain/model/spotify_user.dart';
import 'package:spotify_dribble/core/player/domain/model/player_item.dart';
import 'package:spotify_dribble/features/album/domain/model/album.dart';

class PageData {
  final Album? album;
  final SpotifyUser? user;
  final PlayerItem? playerItem;
  PageData({
    this.album,
    this.user,
    this.playerItem,
  });
}