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
  int offset=0;
  final int limit=50;
  bool isScrolling = false;
  List<Track> likedSongs = [];

  void handleScrollEnd(){
    if(scrollController.position.pixels==scrollController.position.maxScrollExtent){
      print("reached the end of the list");
      offset+=limit+1;
      context.read<TrackCubit>().getUserSavedTracks(limit:limit,offset:offset);
    }
  }

  @override
  void initState() {
    context.read<TrackCubit>().getUserSavedTracks(limit:50,offset:offset);
    scrollController = ScrollController();
    scrollController.addListener(handleScrollEnd);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        HeaderSection(
          iconData: Icons.favorite, 
          title: "Liked Songs"
        ),
        SizedBox(height: 20),
        Container(
          height: 300,
          width: 800,
          padding: EdgeInsets.symmetric(horizontal:25),
          child: BlocBuilder<TrackCubit,TrackStates>(
            builder: (context,state){
              if(state is TrackLoaded){
                if(state.tracks.isNotEmpty){
                  likedSongs.addAll(state.tracks);
                  return ListView.builder(
                      itemCount: likedSongs.length,
                      scrollDirection: Axis.vertical,
                      controller: scrollController,
                      physics: ScrollPhysics(),
                      itemBuilder: (context,index){
                        final Track track = likedSongs[index];
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