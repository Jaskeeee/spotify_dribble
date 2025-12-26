import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:spotify_dribble/core/models/image_model.dart';
import 'package:spotify_dribble/core/player/presentation/cubit/player_cubit.dart';

class PlaybackDisplay extends StatefulWidget {
  final String title;
  final String subtitle;
  final ImageModel coverArt;
  final String repeatState;
  final bool shuffle;
  final int duration;
  const PlaybackDisplay({
    super.key,
    required this.coverArt,
    required this.duration,
    required this.subtitle,
    required this.title,
    required this.shuffle,
    required this.repeatState
  });

  @override
  State<PlaybackDisplay> createState() => _PlaybackDisplayState();
}

class _PlaybackDisplayState extends State<PlaybackDisplay> {
  @override
  Widget build(BuildContext context) {
    final Duration mediaDuration = Duration(milliseconds:widget.duration);
    bool shuffleState = widget.shuffle;
    return Container(
      height:80,
      padding:EdgeInsets.fromLTRB(5,1,0,1),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(10),
            child: Image.network(
              widget.coverArt.imageUrl,
              fit: BoxFit.fill,
              height:70,
              width: 70,
            ),
          ),
          SizedBox(width:20),
          Column(
            mainAxisSize:MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 400,
                child: Text(
                  widget.title,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 18,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                widget.subtitle,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 16
                ),
              ),
            ],
          ),
          Spacer(),
          Text(
            "${mediaDuration.inMinutes}:${(mediaDuration.inSeconds%60).toString().padLeft(2,'0')}",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          SizedBox(width:10),
          IconButton(
            onPressed: (){
              setState(() {
                shuffleState=!shuffleState;
              });
              context.read<PlayerCubit>().shuffle(state:shuffleState);
            }, 
            icon: Icon(
              Bootstrap.shuffle,
              color: shuffleState?Colors.green:Theme.of(context).colorScheme.primary,
              size: 25,
            )
          ),
          SizedBox(width:10),
          IconButton(
            onPressed: (){
            }, 
            icon: Icon(
              Bootstrap.repeat,
              size: 25,
            )
          ),
          SizedBox(width:20),
        ],
      ),
    );
  }
}