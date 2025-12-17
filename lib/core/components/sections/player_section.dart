import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:spotify_dribble/core/components/sections/playback_section.dart';
import 'package:spotify_dribble/core/player/presentation/cubit/player_cubit.dart';

class PlayerSection extends StatefulWidget {
  const PlayerSection({super.key});

  @override
  State<PlayerSection> createState() => _PlayerSectionState();
}

class _PlayerSectionState extends State<PlayerSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(400, 0, 400, 50),
      padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade600.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          style: BorderStyle.solid,
          color: Colors.grey.shade400.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: ()=>context.read<PlayerCubit>().previous(),
            icon: Icon(BoxIcons.bx_rewind, color: Colors.white, size: 35),
          ),
          SizedBox(width:10),
          IconButton(
            onPressed: ()=>context.read<PlayerCubit>().pause(),
            icon: Icon(Icons.pause, color: Colors.white, size: 35),
          ),
          SizedBox(width:10),
          IconButton(
            onPressed:()=>context.read<PlayerCubit>().next(),
            icon: Icon(BoxIcons.bx_fast_forward, color: Colors.white, size: 35),
          ),
          SizedBox(width:40),
          Expanded(
            child: PlaybackSection()
          ),
          SizedBox(width:40),
          IconButton(
            onPressed: ()=>print("previous"),
            icon: Icon(Icons.speaker_outlined, color: Colors.white, size: 35),
          ),
          SizedBox(width:10),
          IconButton(
            onPressed: ()=>print("next"),
            icon: Icon(
              Bootstrap.spotify,
              color: Colors.white,
              size: 35,
            ),
          ),
          SizedBox(width:10),
          IconButton(
            onPressed: ()=>print("next"),
            icon: Icon(Icons.volume_up_rounded, color: Colors.white, size: 35),
          ),
        ],
      ),
    );
  }
}
