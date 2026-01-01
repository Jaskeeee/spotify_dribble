import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_dribble/core/player/presentation/cubit/player_cubit.dart';
class AlbumPlayButton extends StatelessWidget {
  final List<String> ids;
  final bool shuffleState;
  const AlbumPlayButton({
    super.key,
    required this.ids,
    required this.shuffleState
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final List<String> trackURIs = ids;
        context.read<PlayerCubit>().shufflePlay(ids: trackURIs,shuffleState:shuffleState);
      },
      child: Container(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle),
        child: Icon(Icons.play_arrow, color: Colors.black, size: 50),
      ),
    );
  }
}
