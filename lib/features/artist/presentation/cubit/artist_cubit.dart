import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_dribble/features/album/domain/model/album_simplified.dart';
import 'package:spotify_dribble/features/artist/data/spotify_artist_repo.dart';
import 'package:spotify_dribble/features/artist/domain/model/artist.dart';
import 'package:spotify_dribble/features/artist/presentation/cubit/artist_states.dart';

class ArtistCubit extends Cubit<ArtistStates>{
  final SpotifyArtistRepo spotifyArtistRepo;
  ArtistCubit({
    required this.spotifyArtistRepo
  }):super(ArtistInitial());

  Future<void> getArtist({required String id})async{
    try{
      final Artist artist = await spotifyArtistRepo.getArtist(id: id);
      emit(ArtistLoaded(artist: artist));
    }
    catch(e){
      emit(ArtistError(message:e.toString())); 
    }
  }

  Future<void> getArtistAlbums({required String id})async{
    emit(ArtistLoading());
    try{
      final List<AlbumSimplified> albums = await spotifyArtistRepo.getArtistAlbums(id: id);
      emit(ArtistAlbumLoaded(albums: albums));
    }
    catch(e){
      emit(ArtistError(message: e.toString()));
    }
  }
}