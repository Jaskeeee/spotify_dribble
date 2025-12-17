import 'package:spotify_dribble/core/player/domain/model/device.dart';

sealed class DeviceStates {}
class DeviceInitial extends DeviceStates{}
class DeviceLoading extends DeviceStates{}
class DeviceLoaded extends DeviceStates{
  final List<Device> devices;
  DeviceLoaded({required this.devices});
}
class DeviceError extends DeviceStates{
  final String message;
  DeviceError({required this.message});
}
