import 'package:spotify_dribble/core/auth/data/services/api_client.dart';
import 'package:spotify_dribble/core/constants/api_constants.dart';
import 'package:spotify_dribble/core/error/spotify_error.dart';
import 'package:spotify_dribble/features/show/domain/model/show.dart';
import 'package:spotify_dribble/features/show/domain/repo/show_repo.dart';

class SpotifyShowRepo implements ShowRepo{
  final ApiClient _apiClient = ApiClient();
  @override
  Future<Show> getShow({required String id})async{
    try{
      final showData = await _apiClient.get(
        endpoint: "$baseShowEndpoint/$id",
        fromJson: (json)=>Show.fromJson(json)
      );
      if(showData==null){
        throw SpotifyAPIError(message:"Failed to get show");
      }
      return showData;
    }
    catch(e){
      throw SpotifyAPIError(message:e.toString());
    }
  }
}