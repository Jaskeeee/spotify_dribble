import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_dribble/features/track/data/spotify_track_repo.dart';
import 'package:spotify_dribble/features/track/domain/model/track.dart';
import 'package:spotify_dribble/features/track/presentation/cubit/track_states.dart';

class TrackCubit extends Cubit<TrackStates>{
  final SpotifyTrackRepo spotifyTrackRepo;
  TrackCubit({required this.spotifyTrackRepo}):super(TrackInitial());

  Future<void> getUserSavedTracks({int? limit,int? offset})async{
    emit(TrackLoading());
    try{
      final List<Track> tracks = await spotifyTrackRepo.getUserSavedTracks(limit:limit,offset:offset);
      emit(TrackLoaded(tracks: tracks));
    }
    catch(e){
      emit(TrackError(message:e.toString()));
    }
  }
} 