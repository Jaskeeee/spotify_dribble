import 'package:spotify_dribble/core/auth/data/services/api_client.dart';
import 'package:spotify_dribble/core/constants/api_constants.dart';
import 'package:spotify_dribble/core/error/spotify_error.dart';
import 'package:spotify_dribble/features/category/domain/model/browse_category.dart';
import 'package:spotify_dribble/features/category/domain/repo/category_repo.dart';

class SpotifyCategoryRepo implements CategoryRepo{
  final ApiClient _apiClient = ApiClient();
  @override
  Future<List<BrowseCategory>> getSeveralBrowseCategories({int? limit, int? offset})async{
    try{
      final browseCategoriesData = await _apiClient.get(
        endpoint: baseCategoryEndpoint, 
        fromJson: (json)=>(json["categories"]as Map<String,dynamic>)
      );
      if(browseCategoriesData==null){
        return [];
      }
      final browseCategories = browseCategoriesData['items'] as List<dynamic>;
      return browseCategories.map((json)=>BrowseCategory.fromJson(json)).toList();
    }
    catch(e){
      throw SpotifyAPIError(message:e.toString());
    }
  }
  @override
  Future<BrowseCategory> getSingleBrowseCategory({required String categoryId})async{
    try{
      final browseCategory = await _apiClient.get(
        endpoint:"$baseCategoryEndpoint/$categoryId", 
        fromJson: (json)=>BrowseCategory.fromJson(json)
      );
      if(browseCategory==null){
        throw SpotifyAPIError(message:"Failed to Fetch Category");
      }
      return browseCategory;
    }
    catch(e){
      throw SpotifyAPIError(message:e.toString());
    }
  }
}