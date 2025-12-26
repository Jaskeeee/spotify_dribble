import 'package:spotify_dribble/features/category/domain/model/browse_category.dart';

abstract class CategoryRepo {
  Future<List<BrowseCategory>> getSeveralBrowseCategories({int? limit,int? offset});
  Future<BrowseCategory> getSingleBrowseCategory({required String categoryId});
}        