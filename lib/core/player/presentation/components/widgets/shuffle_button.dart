import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:spotify_dribble/core/player/presentation/cubit/player_cubit.dart';

class ShuffleButton extends StatefulWidget {
  final bool shuffleState;
  final double size;
  const ShuffleButton({
    super.key,
    required this.shuffleState,
    required this.size,
  });
  @override
  State<ShuffleButton> createState() => _ShuffleButtonState();
}

class _ShuffleButtonState extends State<ShuffleButton> {
  @override
  Widget build(BuildContext context) {
    bool state = widget.shuffleState;
    return IconButton(
      onPressed:(){
        setState((){
          state=!state;
        });
        context.read<PlayerCubit>().shuffle(state: state);
      }, 
      icon: Icon(
        Bootstrap.shuffle,
        size:widget.size,
        color:widget.shuffleState?Colors.green:Theme.of(context).colorScheme.primary,
      )
    );
  }
}