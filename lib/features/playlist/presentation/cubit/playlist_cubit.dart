import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_dribble/core/error/spotify_error.dart';
import 'package:spotify_dribble/features/playlist/data/spotify_playlist_repo.dart';
import 'package:spotify_dribble/features/playlist/domain/model/playlist_simplified.dart';
import 'package:spotify_dribble/features/playlist/presentation/cubit/playlist_states.dart';

class PlaylistCubit extends Cubit<PlaylistStates>{
  final SpotifyPlaylistRepo spotifyPlaylistRepo;
  PlaylistCubit({
    required this.spotifyPlaylistRepo
  }):super(PlaylistInitial());

  Future<void> getUserPlaylists({required String userId,int? limit,int? offset})async{
    emit(PlaylistLoading());
    try{
      final List<PlaylistSimplified> playlists = await spotifyPlaylistRepo.getUserPlaylists(userId: userId,limit:limit,offset:offset);
      emit(UserPlaylistLoaded(playlists: playlists));
    }
    catch(e){
      throw SpotifyAPIError(message:e.toString());
    }
  }
}