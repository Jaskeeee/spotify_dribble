import 'package:spotify_dribble/core/auth/data/services/api_client.dart';
import 'package:spotify_dribble/core/constants/api_constants.dart';
import 'package:spotify_dribble/core/error/spotify_error.dart';
import 'package:spotify_dribble/features/episode/domain/model/episode.dart';
import 'package:spotify_dribble/features/episode/domain/repo/episode_repo.dart';

class SpotifyEpisodeRepo implements EpisodeRepo{
  final ApiClient _apiClient = ApiClient();
  @override
  Future<Episode> getEpisode({required String id})async{
    try{
      final episodeData = await _apiClient.get(
        endpoint: "$baseEpisodeEndpoint/$id", 
        fromJson: (json)=>(Episode.fromJson(json))
      );
      if(episodeData==null){
        throw SpotifyAPIError(message:"Failed to Fetch Episode");
      }
      return episodeData;
    }
    catch(e){
      throw SpotifyAPIError(message:e.toString());
    }
  }
}