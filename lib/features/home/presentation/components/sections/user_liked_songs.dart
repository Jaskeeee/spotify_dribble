import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_dribble/core/components/sections/header_section.dart';
import 'package:spotify_dribble/core/components/widgets/loading_tile_widget.dart';
import 'package:spotify_dribble/features/home/presentation/components/widget/track_tile.dart';
import 'package:spotify_dribble/features/track/domain/model/track.dart';
import 'package:spotify_dribble/features/track/presentation/cubit/track_cubit.dart';
import 'package:spotify_dribble/features/track/presentation/cubit/track_states.dart';

class UserLikedSongs extends StatefulWidget {
  const UserLikedSongs({super.key});

  @override
  State<UserLikedSongs> createState() => _UserLikedSongsState();
}

class _UserLikedSongsState extends State<UserLikedSongs> {
  late final ScrollController scrollController;
  bool isScrolling = false;
  List<Track> likedSongs = [];
  @override
  void initState() {
    context.read<TrackCubit>().getUserSavedTracks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeaderSection(
          iconData: Icons.favorite, 
          title: "Liked Songs"
        ),
        SizedBox(height: 20),
        Container(
          width: 800,
          height: 320,
          padding: EdgeInsets.symmetric(horizontal:25),
          child: BlocBuilder<TrackCubit,TrackStates>(
            builder: (context,state){
              if(state is TrackLoaded){
                if(state.tracks.isNotEmpty){
                  return ListView.builder(
                      itemCount: state.tracks.length,
                      scrollDirection: Axis.vertical,
                      physics: ScrollPhysics(),
                      itemBuilder: (context,index){
                        final Track track = state.tracks[index];
                        return TrackTile(
                          uri: track.uri,
                          coverArt: track.album.images[0], 
                          duration: track.durationMs, 
                          artists: track.artists, 
                          title: track.name
                        );
                      }
                  );
                }else{
                  return Center(
                    child: SizedBox(
                      child: Text(
                        "No Tracks found!"
                      ),
                    ),
                  );
                }
              }
              else if(state is TrackError){
                return Center(
                  child:Text(
                    state.message
                  ),
                );
              }
              else{
                return ListView.builder(
                  itemCount: 20,
                  itemBuilder: (context,index)=>LoadingTileWidget()
                );
              }
            }
          ),
        )
      ],
    );
  }
}