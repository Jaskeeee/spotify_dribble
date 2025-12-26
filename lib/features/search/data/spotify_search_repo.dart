import 'package:spotify_dribble/core/auth/data/services/api_client.dart';
import 'package:spotify_dribble/core/constants/api_constants.dart';
import 'package:spotify_dribble/core/error/spotify_error.dart';
import 'package:spotify_dribble/features/search/domain/model/search_item.dart';
import 'package:spotify_dribble/features/search/domain/repo/search_repo.dart';

class SpotifySearchRepo extends SearchRepo{
  final ApiClient apiClient = ApiClient();
  @override
  Future<SearchItem> search({required String q, int? limit, int? offset})async{
    try{
      final Map<String,dynamic> queryParameters = {
        "q":q,
        "type":'album,track,playlist,artist'
      };
      final searchData = await apiClient.get(
        endpoint: baseSearchEndpoint, 
        fromJson: (json)=>(SearchItem.fromJson(json)),
        query:Uri(queryParameters:queryParameters).query
      );
      print(searchData);
      if(searchData==null){
        throw SpotifyAPIError(message: "Couldn't Search for that");
      }
      return searchData;
    }
    catch(e){
      throw SpotifyAPIError(message:e.toString());
    }
  }
}