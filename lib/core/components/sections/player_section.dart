import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:spotify_dribble/core/components/sections/available_devices_pop_up.dart';
import 'package:spotify_dribble/core/components/sections/playback_section.dart';
import 'package:spotify_dribble/core/components/sections/volume_pop_up.dart';
import 'package:spotify_dribble/core/components/widgets/common_icon_button.dart';
import 'package:spotify_dribble/core/components/widgets/pause_play_button.dart';
import 'package:spotify_dribble/core/player/presentation/cubit/player_cubit.dart';
import 'package:spotify_dribble/core/player/presentation/cubit/player_states.dart';

class PlayerSection extends StatefulWidget {
  const PlayerSection({super.key});

  @override
  State<PlayerSection> createState() => _PlayerSectionState();
}

class _PlayerSectionState extends State<PlayerSection> {
  double sliderValue = 0;

  @override
  void initState() {
    context.read<PlayerCubit>().getPlaybackState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(400, 0, 400, 50),
      padding: EdgeInsets.fromLTRB(50, 5, 50,5),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiary.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          style: BorderStyle.solid,
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
        ),
      ),
      child: BlocBuilder<PlayerCubit, PlayerStates>(
        builder: (context, state) {
          if (state is PlayerLoaded) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CommonIconButton(
                  iconData: Icons.fast_rewind,
                  onPressed: ()=>context.read<PlayerCubit>().previous(),
                ),
                PausePlayButton(),
                CommonIconButton(
                  iconData: Icons.fast_forward,
                  onPressed: ()=>context.read<PlayerCubit>().next(),
                ),
                SizedBox(width:20),
                Expanded(
                  child: PlaybackSection(
                    playerItem: state.playbackState?.playerItem,
                  ),
                ),
                SizedBox(width:20),
                AvailableDevicesPopUp(
                  activeDevice: state.playbackState?.device,
                ),
                SizedBox(width:20),
                Icon(
                  Icons.menu
                ),
                SizedBox(width:20),
                VolumePopUp(volume: state.playbackState?.device.volumePercent??50)
              ],
            );
          } else if (state is PlayerError) {
            return Center(child: Text(state.message));
          } else {
            return Center(
              child: LoadingAnimationWidget.waveDots(
                color: Theme.of(context).colorScheme.primary,
                size: 40,
              ),
            );
          }
        },
      ),
    );
  }
}
