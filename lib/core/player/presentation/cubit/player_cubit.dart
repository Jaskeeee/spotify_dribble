import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_dribble/core/error/spotify_error.dart';
import 'package:spotify_dribble/core/player/data/spotify_player_repo.dart';
import 'package:spotify_dribble/core/player/domain/model/playback_state.dart';
import 'package:spotify_dribble/core/player/domain/model/player_enums.dart';
import 'package:spotify_dribble/core/player/presentation/cubit/player_states.dart';

class PlayerCubit extends Cubit<PlayerStates>{
  final SpotifyPlayerRepo spotifyPlayerRepo;
  Timer? timer;
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
  Future<void> playbackProgress()async{
    if(timer!=null){
      Stream<int> progress = Stream.periodic(
        Duration(seconds: 1),(tick)=>timer!.tick
      );

    }
    else{
    }
  }

  Future<void> syncPlayback(Duration callbackDelay)async{
    if(timer!=null){
      timer!.cancel();
    }
    timer = Timer.periodic(callbackDelay,(timer)async{
      await getPlaybackState();
    });
  }

  Future<void> getPlaybackState()async{
    try{
      final PlaybackState? playbackState = await spotifyPlayerRepo.getPlaybackState();
      if(playbackState!=null && playbackState.playerItem!=null && playbackState.playerItem!.isTrack && playbackState.isPlaying){
        final int trackDuration = playbackState.playerItem!.track!.durationMs-5000;
        final int trackProgress = trackDuration-playbackState.progressMs;
        int delay=0;
        if(trackProgress>60000){
          delay=30;
        }
        else if(trackProgress<60000 && trackProgress>20000){
          delay=10;
        }
        else{
          delay=2;
        }
        syncPlayback(Duration(seconds:delay));
      }
      if(playbackState!=null && !playbackState.isPlaying && timer!=null){
        print("stopped timer because music paused");
        timer!.cancel();
      }
      emit(PlayerLoaded(playbackState:playbackState));
    }
    catch(e){
      emit(PlayerError(message:e.toString()));
    }
  }

  Future<void> pause({String? deviceId})async{
    try{
      await spotifyPlayerRepo.pause(deviceId: deviceId);
      await Future.delayed(Duration(milliseconds:500));
      await getPlaybackState();
    }
    catch(e){
      emit(PlayerError(message:e.toString()));
    }
  }

  Future<void>resume({String? deviceId})async{
    try{
      await spotifyPlayerRepo.resume(deviceId: deviceId);
      await Future.delayed(Duration(milliseconds:500));
      await getPlaybackState();
    }
    catch(e){
      emit(PlayerError(message:e.toString()));
    }
  }

  Future<void>next({String? deviceId})async{
    emit(PlayerLoading());
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
    emit(PlayerLoading());
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
    emit(PlayerLoading());
    try{
      if(timer!=null){
        timer!.cancel();
      }
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
  
  Future<void> shuffle({String? deviceId,required bool state})async{
    try{
      await spotifyPlayerRepo.shuffle(deviceId: deviceId,state: state);
      await Future.delayed(Duration(milliseconds:500));
      await getPlaybackState();
    }catch(e){
      emit(PlayerError(message:e.toString()));
    }
  }

  Future<void> repeatMode({String? deviceId,required RepeatState state})async{
    try{
      await spotifyPlayerRepo.repeatMode(deviceId: deviceId,state: state);
      await Future.delayed(Duration(milliseconds:500));
      await getPlaybackState();
    }catch(e){
      emit(PlayerError(message: e.toString()));
    }
  }
  Future<void> shufflePlay({required List<String> ids,required bool shuffleState})async{
    emit(PlayerLoading());
    try{ 
      startPlayback(uris:ids);
      await Future.delayed(Duration(milliseconds:1500));
      shuffle(state:shuffleState);
    }catch (e) {
      emit(PlayerError(message: e.toString()));
    }
  }
}