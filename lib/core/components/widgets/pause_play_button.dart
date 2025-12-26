import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_dribble/core/player/presentation/cubit/player_cubit.dart';
import 'package:spotify_dribble/core/player/presentation/cubit/player_states.dart';

class PausePlayButton extends StatefulWidget {
  const PausePlayButton({super.key});

  @override
  State<PausePlayButton> createState() => _PausePlayButtonState();
}

class _PausePlayButtonState extends State<PausePlayButton> {
  bool _isPlaying = false;
  bool _isInitialized = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlayerCubit, PlayerStates>(
      listener: (context, state) {
        if (state is PlayerLoaded) {
          setState(() {
            _isPlaying = state.playbackState?.isPlaying ?? false;
            _isInitialized = true;
          });
        }
      },
      builder: (context, state) {
        if (!_isInitialized && state is PlayerLoaded) {
          _isPlaying = state.playbackState?.isPlaying ?? false;
          _isInitialized = true;
        }

        return IconButton(
          onPressed: () {
            setState(() {
              _isPlaying = !_isPlaying;
            });
            
            if (_isPlaying) {
              context.read<PlayerCubit>().resume();
            } else {
              context.read<PlayerCubit>().pause();
            }
          },
          icon: Icon(
            _isPlaying ? Icons.pause : Icons.play_arrow_sharp,
            color: Theme.of(context).colorScheme.primary,
            size: 35,
          ),
        );
      },
    );
  }
}