import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_dribble/core/player/presentation/cubit/player_cubit.dart';
import 'package:spotify_dribble/features/album/presentation/cubit/album_cubit.dart';
import 'package:spotify_dribble/features/album/presentation/cubit/album_states.dart';

class AlbumPlayButton extends StatelessWidget {
  const AlbumPlayButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlbumCubit, AlbumStates>(
      builder: (context, state) {
        if (state is AlbumTracksLoaded) {
          return GestureDetector(
            onTap: () {
              final List<String> trackURIs = List.generate(
                state.tracks.length,
                (index) => state.tracks[index].uri,
              );
              context.read<PlayerCubit>().startPlayback(uris: trackURIs);
            },
            child: Container(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.play_arrow, color: Colors.black, size: 50),
            ),
          );
        } else {
          return Container(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.play_arrow, color: Colors.black, size: 50),
          );
        }
      },
    );
  }
}
