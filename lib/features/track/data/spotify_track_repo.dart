import 'package:spotify_dribble/core/auth/data/services/api_client.dart';
import 'package:spotify_dribble/core/constants/api_constants.dart';
import 'package:spotify_dribble/core/error/spotify_error.dart';
import 'package:spotify_dribble/features/track/domain/model/track.dart';
import 'package:spotify_dribble/features/track/domain/repo/track_repo.dart';

class SpotifyTrackRepo implements TrackRepo{
  final ApiClient _apiClient = ApiClient();
  @override
  Future<Track> getTrack({required String id})async{
    try{
      final data = await _apiClient.get(
        endpoint: "$baseTrackEndpoint/$id", 
        fromJson: (json)=>Track.fromJson(json)
      );
      if(data==null){
        throw SpotifyAPIError(message:"Track not Found!");
      }
      return data;
    }catch(e){
      throw SpotifyAPIError(message:e.toString());
    }
  }
  
  @override
  Future<List<Track>> getUserSavedTracks({int? limit, int? offset})async{
    try{
      final Map<String,dynamic> queryParameter = {};
      if(limit!=null){
        queryParameter["limit"]=limit.toString();
      }
      if(offset!=null){
        queryParameter["offset"]=offset.toString();
      }
      final String query = Uri(
        queryParameters: queryParameter.isNotEmpty?queryParameter:null
      ).query;
      final savedTracks = await _apiClient.get(
        endpoint: "/v1/me/tracks", 
        fromJson: (json)=>(json["items"] as List<dynamic>),
        query: query
      );
      if(savedTracks==null){
        return [];
      }
      return savedTracks.map((json)=>Track.fromJson(json["track"])).toList();
    }catch(e){
      throw SpotifyAPIError(message:e.toString());
    }
  }
  
  @override
  Future<List<bool>> checkUserSavedTracks({required List<String> ids})async{
    throw UnimplementedError();
  }
}