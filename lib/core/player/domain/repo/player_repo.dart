import 'package:spotify_dribble/core/player/domain/model/device.dart';
import 'package:spotify_dribble/core/player/domain/model/playback_state.dart';
import 'package:spotify_dribble/core/player/domain/model/player_enums.dart';

abstract class PlayerRepo {
  Future<List<Device>> getavailableDevices();
  Future<void> syncDevice();
  Future<void> transferPlayback({required List<String> deviceIds,bool? play});
  Future<PlaybackState?> getPlaybackState();
  Future<void> pause({String? deviceId});
  Future<void> resume({String? deviceId});
  Future<void> next({String? deviceId});
  Future<void> previous({String? deviceId});
  Future<void> seek({String? deviceId,required int positionMs});
  Future<void> shuffle({String? deviceId,required bool state});
  Future<void> volume({String? deviceId,required int volume});
  Future<void> repeatMode({String? deviceId,required RepeatState state});
  Future<void> queue({String? deviceId,required String uri}); 
}