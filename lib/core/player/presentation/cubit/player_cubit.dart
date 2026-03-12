import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    checkSpotifyd();
    // _syncSpotifyd();
    // syncSpotifyd();
    syncWithSpotifyd();
  }

  Future<void> checkSpotifyd()async{
    await spotifyPlayerRepo.checkSpotifyd();
    await _syncSpotifyd();
  }

  // Note: because I know my forgetful ass will get confused:
  // the logic for syncing the playback is as follows:
  // 1. We have to perform a sanity check for spotifyd, refer to logic in Emma
  // 2. after the sanity check it has to be pinged as the active device, ONLY when no other device has active playback on it
  // 3. the problem about syncing the "currentPlayer" via MPRIS is that it's only visible to MPRIS when a playback is active on it
  // which means even if spotifyd is the active device in the eyes of the API, as long as there's no playback on it 
  // the MPRIS will not detect it
  // a potential solution might be trying to sync it either when the playback state is fetched


  Future<void> syncSpotifyd()async{
    emit(PlayerLoading());
    try{
      await spotifyPlayerRepo.checkSpotifyd();
    }
    catch(e){
      emit(PlayerError(message:e.toString()));
    }
  }

  Future<void> transferTospotifyd()async{
    try{
      await spotifyPlayerRepo.transferTospotifyd();
      await Future.delayed(Duration(seconds:2));
      await getPlaybackState();
    }
    catch(e){
      emit(PlayerError(message:e.toString()));
    }
  }


  Future<void> _syncSpotifyd()async{
    try{
      await spotifyPlayerRepo.syncDevice();
      final PlaybackState? playbackState = await spotifyPlayerRepo.getPlaybackState();
      emit(PlayerLoaded(playbackState: playbackState));
      await Future.delayed(Duration(milliseconds:500));
      syncWithSpotifyd();
      await spotifyPlayerRepo.getPlayerForMPRIS();
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

  Future<void> syncWithSpotifyd()async{
    try{
      spotifyPlayerRepo.listenToSpotifyd().listen((log)async{
        if(log.contains("loaded")){
          // await getPlaybackState();
          await spotifyPlayerRepo.getPlayerForMPRIS();
        }

        if(log.contains("active device is <>")){
          await transferTospotifyd();
        }
      },
      onError:(e)=>emit(PlayerError(message:e.toString()))
      );
    }
    catch(e){
      emit(PlayerError(message: e.toString()));
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
      await spotifyPlayerRepo.getPlayerForMPRIS();
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
      // idkAnymore();
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