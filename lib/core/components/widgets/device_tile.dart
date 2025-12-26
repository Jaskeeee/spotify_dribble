import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_dribble/core/constants/app_constants.dart';
import 'package:spotify_dribble/core/player/domain/model/device.dart';
import 'package:spotify_dribble/core/player/presentation/cubit/player_cubit.dart';

class DeviceTile extends StatelessWidget {
  final Device device;
  final Device? activeDevice;
  const DeviceTile({
    super.key,
    required this.device,
    required this.activeDevice
  });
  @override
  Widget build(BuildContext context) {
    final List<String> ids = [];
    ids.add(device.id);
    final Color activeDeviceColor = activeDevice?.name!=null
              ?(activeDevice!.name==device.name)?Colors.green:Theme.of(context).colorScheme.primary
              :Theme.of(context).colorScheme.primary;
    return GestureDetector(
      onTap: (){
        context.read<PlayerCubit>().transferPlayback(ids:ids,play:true);
        Navigator.pop(context);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical:5),
        child: Row(
          children: [
            Icon(
              deviceTypes[device.type],
              color:activeDeviceColor,
            ),
            SizedBox(width: 10),
            Text(
              device.name,
              style: TextStyle(
                color:activeDeviceColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
