import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_dribble/core/components/widgets/playback_display.dart';
import 'package:spotify_dribble/core/components/widgets/playback_display_tile.dart';
import 'package:spotify_dribble/core/player/domain/model/player_item.dart';
import 'package:spotify_dribble/core/player/presentation/cubit/player_cubit.dart';
import 'package:spotify_dribble/features/episode/domain/model/episode.dart';
import 'package:spotify_dribble/features/track/domain/model/track.dart';

class PlaybackSection extends StatefulWidget {
  final String repeatState;
  final bool shuffleState;
  final PlayerItem? playerItem;
  final GlobalKey<NavigatorState> navKey;
  const PlaybackSection({
    super.key,
    required this.playerItem,
    required this.repeatState,
    required this.shuffleState,
    required this.navKey
  });

  @override
  State<PlaybackSection> createState() => _PlaybackSectionState();
}

class _PlaybackSectionState extends State<PlaybackSection> {
  @override
  void initState() {
    context.read<PlayerCubit>().getPlaybackState();
    super.initState();
  }
  Widget checkPlaybackItem(PlayerItem? playerItem){  
    if(playerItem == null) {
      return Padding(
        padding: const EdgeInsets.all(30),
        child: Row(
          children: [
            Icon(
              Icons.music_note,
              color: Theme.of(context).colorScheme.primary,
              size: 16,
            ),
            SizedBox(width:10),
            SizedBox(width:10),
            Text(
              "No playback Available",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }
    if(playerItem.isTrack){
      final Track track = playerItem.track!;
      return PlaybackDisplay(
        title: track.name, 
        coverArt: track.album.images[0], 
        duration: track.durationMs, 
        subtitle: track.artists[0].name, 
        repeatState: widget.repeatState,
        shuffle: widget.shuffleState,
        // trailingWidget: Text("Track")
      );   
    }
    if(playerItem.isEpisode){
      final Episode episode = playerItem.episode!;
      return PlaybackDisplayTile(
        title: episode.name, 
        coverArt: episode.images[0], 
        duration: episode.durationMs, 
        subtitle: episode.show.name, 
        trailingWidget: Text("Episode")
      );
    }
    return Padding(
        padding: EdgeInsets.all(30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.music_note,
              color: Theme.of(context).colorScheme.primary,
              size: 25,
            ),
            SizedBox(width:20,),
            Text(
               "No playback Available",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16
              ),
            ),
          ],
        ),
      );
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>widget.navKey.currentState?.pushReplacementNamed('/listen'),
      child: Container(
        padding: EdgeInsets.only(top:1,bottom:1,left:2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.grey.shade800.withValues(alpha: 0.78),
        ),
        child: checkPlaybackItem(widget.playerItem)
      ),
    );
  }
}
