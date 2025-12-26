import 'package:spotify_dribble/core/auth/data/services/api_client.dart';
import 'package:spotify_dribble/core/constants/api_constants.dart';
import 'package:spotify_dribble/core/error/spotify_error.dart';
import 'package:spotify_dribble/features/album/domain/model/album.dart';
import 'package:spotify_dribble/features/album/domain/repo/album_repo.dart';
import 'package:spotify_dribble/features/track/domain/model/track_simplified.dart';

class SpotifyAlbumRepo implements AlbumRepo{
  final ApiClient _apiClient = ApiClient();
  @override
  Future<Album> getAlbum({required String id})async{
    try{
      final album = await _apiClient.get(
        endpoint: "$baseAlbumEndpoint/id", 
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
  Future<List<TrackSimplified>> getAlbumTracks({required String id, int? limit, int? offset})async{
    try{
      final Map<String,dynamic> queryParameters = {};
      if(limit!=null){
        final String finalLimit = limit<=50?limit.toString():"50";
        queryParameters["limit"]=finalLimit;
      }
      if(offset!=null){
        queryParameters["offset"]=offset.toString();
      }
      final String query = Uri(
        queryParameters: queryParameters.isNotEmpty?queryParameters:null
      ).query;
      final tracksData = await _apiClient.get(
        endpoint: "$baseAlbumEndpoint/$id/tracks", 
        fromJson: (json)=>(json["items"] as List<dynamic>),
        query: query
      );
      if(tracksData==null){
        return [];
      }
      return tracksData.map((json)=>TrackSimplified.fromJson(json)).toList();
    }catch(e){
      throw SpotifyAPIError(message: e.toString());
    }
    
  }

  @override
  Future<List<Album>> getAlbums({required List<String> ids})async{
    try{
      final String queryParameters = Uri(queryParameters:{"ids":ids.join(',')}).query;
      final albumsData = await _apiClient.get(
        endpoint: baseAlbumEndpoint, 
        fromJson: (json)=>(json["albums"] as List<dynamic>),
        query: queryParameters
      );
      if(albumsData==null){
        throw SpotifyAPIError(message: "The Albums couldn't be loaded");
      }
      return albumsData.map((json)=>Album.fromJson(json)).toList();
    }
    catch(e){
      throw SpotifyAPIError(message:e.toString());
    }
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