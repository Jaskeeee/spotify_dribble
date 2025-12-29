import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:spotify_dribble/core/components/widgets/hover_title.dart';
import 'package:spotify_dribble/core/constants/api_constants.dart';
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
    String currentRepeatState = widget.repeatState;
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
                child:HoverTitle(
                  title: widget.title, 
                  fontSize: 18, 
                  onTap: ()=>print("help i am being touched"), 
                  color: Theme.of(context).colorScheme.primary,
                  overflow: TextOverflow.ellipsis,
                )
              ),
              HoverTitle(
                title: widget.subtitle, 
                fontSize: 16, 
                onTap: ()=>print("help i am being touched"), 
                color: Theme.of(context).colorScheme.secondary
              )
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
              String state;
              int nextIndex = 0;
              int currentIndex = repeatStates.indexWhere((state)=>state==widget.repeatState);
              nextIndex= currentIndex+1;
              if(nextIndex>=repeatStates.length){
                state = repeatStates[0];
                nextIndex=0;
              }else{
                state = repeatStates[nextIndex];
              }
              setState(() {
                currentRepeatState=state;
              });
              context.read<PlayerCubit>().repeatMode(state: state);
            }, 
            icon: Icon(
            (currentRepeatState=="context"||currentRepeatState=="off")
            ?Bootstrap.repeat
            :Bootstrap.repeat_1,
              size: 25,
              color: (currentRepeatState=="context"||currentRepeatState=="track")
              ?Colors.green
              :Theme.of(context).colorScheme.primary,
            )
          ),
          SizedBox(width:20),
        ],
      ),
    );
  }
}