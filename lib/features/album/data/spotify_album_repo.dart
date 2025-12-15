import 'package:spotify_dribble/core/auth/data/services/api_client.dart';
import 'package:spotify_dribble/core/error/spotify_error.dart';
import 'package:spotify_dribble/features/album/model/album.dart';
import 'package:spotify_dribble/features/album/repo/album_repo.dart';
import 'package:spotify_dribble/features/track/model/track.dart';

class SpotifyAlbumRepo implements AlbumRepo{
  final String baseEndpoint = "/v1/albums/";
  final ApiClient _apiClient = ApiClient();
  @override
  Future<Album> getAlbum({required String id})async{
    try{
      final album = await _apiClient.get(
        endpoint: "${baseEndpoint}id", 
        fromJson: ((json)=>Album.fromJson(json))
      );
      if(album==null){
        throw SpotifyAPIError(message:"Album not found");
      }
      return album;
    }catch(e){
      throw SpotifyAPIError(message:e.toString());
    }
  }

  @override
  Future<List<Track>> getAlbumTracks({required String id, int? limit, int? offset})async{
    try{
      final Map<String,dynamic> queryParameters = {};
      if(limit!=null){
        queryParameters["limit"]=limit.toString();
      }
      if(offset!=null){
        queryParameters["offset"]=offset.toString();
      }
      final String query = Uri(
        queryParameters: queryParameters.isNotEmpty?queryParameters:null
      ).query;
      final tracksData = await _apiClient.get(
        endpoint: "$baseEndpoint$id/tracks", 
        fromJson: (json)=>(json["items"] as List<dynamic>),
        query: query
      );
      if(tracksData==null){
        return [];
      }
      return tracksData.map((json)=>Track.fromJson(json)).toList();
    }catch(e){
      throw SpotifyAPIError(message: e.toString());
    }
    
  }

  @override
  Future<Album> getAlbums({required List<String> ids}) {
    // TODO: implement getAlbums
    throw UnimplementedError();
  }

  @override
  Future<List<Album>> getUserSavedAlbums({int? limit, int? offset})async{
    try{
      final Map<String,dynamic> queryParameters = {};
      if(limit!=null){
        queryParameters["limit"]=limit.toString();
      }
      if(offset!=null){
        queryParameters["offset"]=offset.toString();
      }
      final String? query = queryParameters.isNotEmpty
      ?Uri(
        queryParameters: queryParameters
      ).query
      :null;
      final userAlbumData = await _apiClient.get(
        endpoint: "/v1/me/albums", 
        fromJson: (json)=>(json["items"] as List<dynamic>),
        query: query
      );
      if(userAlbumData==null){
        return [];
      }
      return userAlbumData.map((json)=>Album.fromJson(json["album"])).toList();
    }
    catch(e){
      throw SpotifyAPIError(message:e.toString());
    }
  }

}