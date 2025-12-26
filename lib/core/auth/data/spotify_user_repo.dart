import 'package:spotify_dribble/core/auth/data/services/api_client.dart';
import 'package:spotify_dribble/core/auth/domain/model/spotify_user.dart';
import 'package:spotify_dribble/core/auth/domain/repo/user_repo.dart';
import 'package:spotify_dribble/core/error/spotify_error.dart';
import 'package:spotify_dribble/features/artist/domain/model/artist.dart';

class SpotifyUserRepo implements UserRepo{
  final ApiClient _apiClient = ApiClient();
  final String baseEndpoint = "/v1/me";
  @override
  Future<SpotifyUser?> getCurrentUserProfile()async{
    try{
      final SpotifyUser? user = await _apiClient.get(
        endpoint: "/v1/me",
        fromJson: (json)=>SpotifyUser.fromJson(json)
      );
      if(user!=null){
        return user;
      }else{
        return null;
      }
    }catch(e){
      throw SpotifyAPIError(message:e.toString());
    }
  }
  @override
  Future<SpotifyUser?> getUserProfile(String uid) {
    throw UnimplementedError();
  }
  @override
  Future<void> followPlayList(String playlistId) {
    throw UnimplementedError();
  }
  @override
  Future<void> unfollowPlaylist(String playlistId) {
    throw UnimplementedError();
  }

  @override
  Future<List<Artist>> getFollowedArtists({int? limit})async{
    try{
      final Map<String,dynamic> queryParameter= {
        "type":"artist"
      };
      if(limit!=null){
        queryParameter["limit"]=limit.toString();
      }
      final followedArtist = await _apiClient.get(
        endpoint: '$baseEndpoint/following', 
        fromJson: (json)=>(json["artists"]["items"] as List<dynamic>),
        queryParameters: queryParameter
      );
      if(followedArtist==null){
        throw SpotifyAPIError(message:"Couldn't Load User Followed Artist");
      } 
      return followedArtist.map((json)=>Artist.fromJson(json)).toList();
    }
    catch(e){
      throw SpotifyAPIError(message:e.toString());
    }
  }
}