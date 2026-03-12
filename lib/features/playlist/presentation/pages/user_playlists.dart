import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_dribble/core/models/page_data.dart';
import 'package:spotify_dribble/features/playlist/domain/model/playlist_simplified.dart';
import 'package:spotify_dribble/features/playlist/presentation/components/sections/playlist_display_tile.dart';
import 'package:spotify_dribble/features/playlist/presentation/cubit/playlist_cubit.dart';
import 'package:spotify_dribble/features/playlist/presentation/cubit/playlist_states.dart';

class UserPlaylists extends StatefulWidget {
  final PageData pageData;
  const UserPlaylists({
    super.key,
    required this.pageData
  });

  @override
  State<UserPlaylists> createState() => _UserPlaylistsState();
}

class _UserPlaylistsState extends State<UserPlaylists> {

  @override
  void initState() {
    context.read<PlaylistCubit>().getUserPlaylists(userId:widget.pageData.user!.id);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaylistCubit,PlaylistStates>(
      builder: (context,state){
        if(state is UserPlaylistLoaded){
          List<PlaylistSimplified> playlists = state.playlists;
          if(playlists.isNotEmpty){
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:2,
                mainAxisExtent:250,
              ),
              itemCount: state.playlists.length,
              itemBuilder: (context,index){
                final PlaylistSimplified playlist = state.playlists[index];
                return Padding(
                  padding: const EdgeInsets.fromLTRB(10,20,10,20),
                  child: PlaylistDisplayTile(
                    playlist: playlist,
                  ),
                );
              }
            );
          }else{
            return Center(
              child: Text(
                "No Playlist Found lmao, ps: kill yourself"
              ),
            );
          }
        }
        else if(state is PlaylistError){
          return Center(
            child: Text(
              state.message,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16
              ),
            ),
          );
        }
        else{
          return CircularProgressIndicator();
        }
      }
    );
  }
}