import 'package:spotify_dribble/core/auth/data/services/api_client.dart';
import 'package:spotify_dribble/core/auth/domain/model/spotify_user.dart';
import 'package:spotify_dribble/core/auth/domain/repo/user_repo.dart';
import 'package:spotify_dribble/core/error/spotify_error.dart';

class SpotifyUserRepo implements UserRepo{
  final ApiClient _apiClient = ApiClient();
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
    // TODO: implement getUserProfile
    throw UnimplementedError();
  }
  @override
  Future<void> followPlayList(String playlistId) {
    // TODO: implement followPlayList
    throw UnimplementedError();
  }
  @override
  Future<void> unfollowPlaylist(String playlistId) {
    // TODO: implement unfollowPlaylist
    throw UnimplementedError();
  }
}