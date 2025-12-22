import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_dribble/core/player/data/spotify_player_repo.dart';
import 'package:spotify_dribble/core/player/domain/model/playback_state.dart';
import 'package:spotify_dribble/core/player/presentation/cubit/player_states.dart';

class PlayerCubit extends Cubit<PlayerStates>{
  final SpotifyPlayerRepo spotifyPlayerRepo;

  PlayerCubit({
    required this.spotifyPlayerRepo,
  }):super(PlayerInitial()){
    _syncSpotifyd();
  }

  Future<void> _syncSpotifyd()async{
    try{
      await spotifyPlayerRepo.syncDevice();
      final PlaybackState? playbackState = await spotifyPlayerRepo.getPlaybackState();
      emit(PlayerLoaded(playbackState: playbackState));
    }
    catch(e){
      emit(PlayerError(message:e.toString()));
    }
  }

  Future<void> getPlaybackState()async{
    try{
      final PlaybackState? playbackState = await spotifyPlayerRepo.getPlaybackState();
      emit(PlayerLoaded(playbackState:playbackState));
    }
    catch(e){
      emit(PlayerError(message:e.toString()));
    }
  }

  Future<void> pause({String? deviceId})async{
    try{
      await spotifyPlayerRepo.pause(deviceId: deviceId);
      await Future.delayed(Duration(seconds:1,milliseconds:50));
      await getPlaybackState();
    }
    catch(e){
      emit(PlayerError(message:e.toString()));
    }
  }

  Future<void>resume({String? deviceId})async{
    try{
      await spotifyPlayerRepo.resume(deviceId: deviceId);
      await Future.delayed(Duration(seconds:1,milliseconds:50));
      await getPlaybackState();
    }
    catch(e){
      emit(PlayerError(message:e.toString()));
    }
  }

  Future<void>next({String? deviceId})async{
    try{
      await spotifyPlayerRepo.next(deviceId: deviceId);
      await Future.delayed(Duration(seconds:1,milliseconds:50));
      await getPlaybackState();
    }
    catch(e){
      emit(PlayerError(message:e.toString()));
    }
  }
  
  Future<void>previous({String? deviceId})async{
    try{
      await spotifyPlayerRepo.previous(deviceId:deviceId);
      await Future.delayed(Duration(seconds:1,milliseconds:50));
      await getPlaybackState();
    }
    catch(e){
      emit(PlayerError(message:e.toString()));
    }
  }

  Future<void>transferPlayback({required List<String> ids,bool? play})async{
    try{
      await spotifyPlayerRepo.transferPlayback(deviceIds:ids,play:play);
      await Future.delayed(Duration(seconds:2));
      await getPlaybackState();
    }
    catch(e){
      emit(PlayerError(message: e.toString()));
    }
  }

  Future<void>startPlayback({required List<String> uris,String? deviceId})async{
    try{
      await spotifyPlayerRepo.startPlayback(uris: uris,deviceId:deviceId);
      await Future.delayed(Duration(seconds:1));
      await getPlaybackState();
    }catch(e){
      emit(PlayerError(message: e.toString()));
    }
  }

  Future<void>volume({String? deviceId,required int volume})async{
    try{
      await spotifyPlayerRepo.volume(volume: volume,deviceId:deviceId);
      await Future.delayed(Duration(seconds: 1));
      await getPlaybackState();
    }catch(e){
      emit(PlayerError(message: e.toString()));
    }
  }
}