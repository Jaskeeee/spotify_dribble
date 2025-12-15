import 'package:spotify_dribble/core/auth/data/services/api_client.dart';
import 'package:spotify_dribble/core/error/spotify_error.dart';
import 'package:spotify_dribble/features/track/model/track.dart';
import 'package:spotify_dribble/features/track/repo/track_repo.dart';

class SpotifyTrackRepo implements TrackRepo{
  final String baseEndpoint = "/v1/me/tracks/";
  final ApiClient _apiClient = ApiClient();
  @override
  Future<Track?> getTrack({required String id})async{
    try{
      return await _apiClient.get(
        endpoint: "${baseEndpoint}id", 
        fromJson: (json)=>Track.fromJson(json)
      );
    }catch(e){
      throw SpotifyAPIError(message:e.toString());
    }
  }
}