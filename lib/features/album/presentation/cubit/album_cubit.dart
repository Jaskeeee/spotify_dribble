import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_dribble/features/album/data/spotify_album_repo.dart';
import 'package:spotify_dribble/features/album/domain/model/album.dart';
import 'package:spotify_dribble/features/album/presentation/cubit/album_states.dart';

class AlbumCubit extends Cubit<AlbumStates>{
  final SpotifyAlbumRepo spotifyAlbumRepo;
  AlbumCubit({
    required this.spotifyAlbumRepo
  }):super(AlbumInitial());

  Future<void> getAlbum({required String id })async{
    emit(AlbumLoading());
    try{
    }
    catch(e){
      emit(AlbumError(message:e.toString()));
    }
  } 

  Future<void> getUserSavedAlbums({int? limit,int? offset})async{    
    emit(AlbumLoading());
    try{
      final List<Album> albums = await spotifyAlbumRepo.getUserSavedAlbums(limit:limit,offset:offset);
      if(albums.isEmpty){
        emit(UserAlbumLoaded(albums:[]));
      }
      emit(UserAlbumLoaded(albums: albums));
    }
    catch(e){
      emit(AlbumError(message:e.toString()));
    }
  }
}