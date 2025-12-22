import 'package:spotify_dribble/core/auth/data/services/api_client.dart';
import 'package:spotify_dribble/core/error/spotify_error.dart';
import 'package:spotify_dribble/features/album/domain/model/album.dart';
import 'package:spotify_dribble/features/artist/domain/model/artist.dart';
import 'package:spotify_dribble/features/artist/domain/repo/artist_repo.dart';

class SpotifyArtistRepo implements ArtistRepo{
  final ApiClient _apiClient = ApiClient();
  final String baseEndpoint = "/v1/artists/";
  @override
  Future<Artist> getArtist({required String id})async{
    try{
      final artistData = await _apiClient.get(
        endpoint: "$baseEndpoint$id",
        fromJson: ((json)=>Artist.fromJson(json))
      );
      if(artistData==null){
        throw SpotifyAPIError(message: "Couldn't find the artist Specified");
      }
      return artistData;
    }
    catch(e){
      throw SpotifyAPIError(message:e.toString());
    }
  }
  
  @override
  Future<List<Album>> getArtistAlbums({required String id})async{
    try{
      final artistAlbums = await _apiClient.get(
        endpoint: "$baseEndpoint$id/albums", 
        fromJson: (json)=>(json as List<dynamic>)
      );
      if(artistAlbums==null){
        throw SpotifyAPIError(message:"Couldn't load Artist Albums");
      }
      return artistAlbums.map((json)=>Album.fromJson(json)).toList();
    }
    catch(e){
      throw SpotifyAPIError(message:e.toString());
    }
  }
}