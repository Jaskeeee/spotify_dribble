import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:spotify_dribble/core/player/presentation/cubit/player_cubit.dart';
import 'package:spotify_dribble/core/player/presentation/cubit/player_states.dart';
import 'package:spotify_dribble/features/track/model/track.dart';

class PlaybackSection extends StatefulWidget {
  const PlaybackSection({super.key});

  @override
  State<PlaybackSection> createState() => _PlaybackSectionState();
}

class _PlaybackSectionState extends State<PlaybackSection> {
  @override
  void initState() {
    context.read<PlayerCubit>().getPlaybackState();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top:1,bottom:1,left:2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey.shade800.withValues(alpha: 0.78),
      ),
      child: BlocBuilder<PlayerCubit,PlayerStates>(
        builder: (context,state){
          if(state is PlayerLoaded){
            if(state.playbackState!=null){
              if(state.playbackState!.playerItem!.isTrack){
                final Track track = state.playbackState!.playerItem!.track!;
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: SizedBox(
                      child: Image.network(
                        track.album.images[0].imageUrl,
                        filterQuality: FilterQuality.high,
                        width: 60,
                        height: 60,
                      ),
                    ),
                  ),
                  title:Text(
                    track.name,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white
                    ),
                  ),
                  titleAlignment: ListTileTitleAlignment.center,
                  subtitle: Text(
                    track.artists[0].name,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey
                    ),
                  ),
                );
              }else{
                return Center(
                  child:Text("Podcast episode lamo"),
                );
              }
            }else{
              return Center(
                child: Text("No Playback"),
              );
            }
          }else if(state is PlayerError){
            return Center(
              child: Text(
                state.message,
                style: TextStyle(
                  color: Colors.grey
                ),
              ),
            );
          }
          else{
            return Center(
              child:LoadingAnimationWidget.waveDots(
                color: Colors.white, 
                size: 30
              ),
            );
          }
        }
      ),
    );
  }
}
