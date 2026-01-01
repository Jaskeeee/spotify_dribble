import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:spotify_dribble/core/player/domain/model/player_enums.dart';
import 'package:spotify_dribble/core/player/presentation/cubit/player_cubit.dart';

class RepeatButton extends StatefulWidget {
  final String repeatState;
  const RepeatButton({
    super.key,
    required this.repeatState
  });
  

  @override
  State<RepeatButton> createState() => _RepeatButtonState();
}

class _RepeatButtonState extends State<RepeatButton> {
  @override
  Widget build(BuildContext context) {
    RepeatState state = RepeatState.values.firstWhere((e)=>e.name==widget.repeatState);
    return IconButton(
      onPressed: (){
        RepeatState nextState;
        int currentIndex=RepeatState.values.indexWhere((e)=>e==state);
        if((currentIndex+1)>=RepeatState.values.length){
          nextState = RepeatState.values[0];
        }
        else{
          nextState = RepeatState.values[(currentIndex+1)];
        }
        setState(() {
          state=nextState;
        });
        context.read<PlayerCubit>().repeatMode(state:nextState);
      }, 
      icon:Icon(
        (state==RepeatState.context||state==RepeatState.off)
        ?Bootstrap.repeat
        :Bootstrap.repeat_1,
        size: 25,
        color: (state==RepeatState.context||state==RepeatState.track)
        ?Colors.green:Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
