import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_popup/flutter_popup.dart';
import 'package:spotify_dribble/core/player/presentation/cubit/player_cubit.dart';

class VolumePopUp extends StatefulWidget {
  final int? volume;
  const VolumePopUp({
    super.key,
    required this.volume
  });

  @override
  State<VolumePopUp> createState() => _VolumePopUpState();
}

class _VolumePopUpState extends State<VolumePopUp> {
  @override
  Widget build(BuildContext context) {
    double? volumePer = widget.volume!.toDouble();
    return CustomPopup(
      backgroundColor: Theme.of(context).colorScheme.secondary.withValues(alpha:0.5),
      arrowColor: Theme.of(context).colorScheme.secondary.withValues(alpha:0.5),
      position: PopupPosition.top,
      content: StatefulBuilder(
        builder: (context,state){
          return SizedBox(
            height: 20,
            width: 200,
            child: Slider(
              thumbColor: Colors.green,
              inactiveColor: Colors.grey.shade800.withValues(alpha:0.8),
              activeColor: Colors.green,
              value: volumePer!, 
              max: 100,
              min: 0,
              onChanged: (double value){
                state((){
                  volumePer = value;
                });
              },
              onChangeEnd:(double value){
                print("volume value: ${value.toInt()}");
                context.read<PlayerCubit>().volume(volume:value.toInt());
              },
            ),
          );
        }
      ), 
      child: Icon(
        Icons.volume_up,
        color: Theme.of(context).colorScheme.primary,
      )
    );
  }
}