import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_popup/flutter_popup.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:spotify_dribble/core/player/presentation/components/widgets/device_tile.dart';
import 'package:spotify_dribble/core/constants/app_constants.dart';
import 'package:spotify_dribble/core/player/domain/model/device.dart';
import 'package:spotify_dribble/core/player/presentation/cubit/device_cubit.dart';
import 'package:spotify_dribble/core/player/presentation/cubit/device_states.dart';

class AvailableDevicesPopUp extends StatefulWidget {
  final Device? activeDevice;
  const AvailableDevicesPopUp({
    super.key,
    required this.activeDevice
  });

  @override
  State<AvailableDevicesPopUp> createState() => _AvailableDevicesPopUpState();
}

class _AvailableDevicesPopUpState extends State<AvailableDevicesPopUp>with RouteAware{
  @override
  Widget build(BuildContext context) {
    return CustomPopup(
      backgroundColor: Theme.of(context).colorScheme.secondary.withValues(alpha:0.5),
      arrowColor: Theme.of(context).colorScheme.secondary.withValues(alpha:0.5),
      onBeforePopup: (){
        Future.delayed(Duration(seconds: 1));
        context.read<DeviceCubit>().getavailableDevices();
      },
      content: Container(
        width: 200,
        height: 250,
        padding: EdgeInsets.symmetric(horizontal:10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Devices:",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize:16,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height:20),
            BlocBuilder<DeviceCubit,DeviceStates>(
              builder: (context,state){
                if(state is DeviceLoaded){
                  if(state.devices.isNotEmpty){
                    return SizedBox(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: state.devices.length,
                        itemBuilder:(context,index){
                          final Device device = state.devices[index];
                          return DeviceTile(
                            device: device,
                            activeDevice:widget.activeDevice,
                          );
                        }
                      ),
                    );
                  }else{
                    return Center(
                      child: Text("No devices Available"),
                    );
                  }
                }
                else if(state is DeviceError){
                  return Center(
                    child: Text(state.message),
                  );
                }else{
                  return Center(
                    child: LoadingAnimationWidget.waveDots(
                      color:Theme.of(context).colorScheme.primary, 
                      size: 40
                    ),
                  );
                }
              }
            )
          ],
        ),
      ),
      position: PopupPosition.top,
      child: Icon(
        deviceTypes[widget.activeDevice?.type]??Icons.devices
      ),
    );
  }
}