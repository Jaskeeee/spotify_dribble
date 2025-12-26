import 'package:spotify_dribble/features/category/domain/model/browse_category.dart';

sealed class CategoryStates {}
class CategoryInitial extends CategoryStates{}
class CategoryLoading extends CategoryStates{}
class CategoriesLoaded extends CategoryStates{
  final List<BrowseCategory> categories;
  CategoriesLoaded({
    required this.categories
  });
}
class CategoryLoaded extends CategoryStates{
  final BrowseCategory category;
  CategoryLoaded({
    required this.category
  });
}
class CategoryError extends CategoryStates{
  final String message;
  CategoryError({
    required this.message
  });
}