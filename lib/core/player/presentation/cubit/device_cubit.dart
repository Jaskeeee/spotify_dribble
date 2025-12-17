import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_dribble/core/player/data/spotify_player_repo.dart';
import 'package:spotify_dribble/core/player/domain/model/device.dart';
import 'package:spotify_dribble/core/player/presentation/cubit/device_states.dart';

class DeviceCubit extends Cubit<DeviceStates>{
  final SpotifyPlayerRepo spotifyPlayerRepo;
  DeviceCubit({
    required this.spotifyPlayerRepo
  }):super(DeviceInitial());

  Future<void> getavailableDevices()async{
    emit(DeviceLoading());
    try{
      final List<Device> devices = await spotifyPlayerRepo.getavailableDevices();
      emit(DeviceLoaded(devices: devices));
    }
    catch(e){
      emit(DeviceError(message:e.toString()));
    }
  }
}