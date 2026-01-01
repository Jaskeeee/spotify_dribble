import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class AlbumShuffleButton extends StatefulWidget{
  final void Function() onPressed;
  final bool shuffleState;
  const AlbumShuffleButton({
    super.key, 
    required this.shuffleState,
    required this.onPressed
  });

  @override
  State<AlbumShuffleButton> createState() => _AlbumShuffleButtonState();
}

class _AlbumShuffleButtonState extends State<AlbumShuffleButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed:widget.onPressed,
      icon: Icon(
        Bootstrap.shuffle,
        size: 60,
        color: widget.shuffleState?Colors.green:Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
