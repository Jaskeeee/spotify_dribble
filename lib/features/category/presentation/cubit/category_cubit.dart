import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_dribble/features/category/data/spotify_category_repo.dart';
import 'package:spotify_dribble/features/category/domain/model/browse_category.dart';
import 'package:spotify_dribble/features/category/presentation/cubit/category_states.dart';

class CategoryCubit extends Cubit<CategoryStates>{
  final SpotifyCategoryRepo spotifyCategoryRepo;
  CategoryCubit({
    required this.spotifyCategoryRepo
  }):super(CategoryInitial());

  Future<void> getSeveralBrowseCategories({int? limit,int? offset})async{
    emit(CategoryLoading());
    try{
      final List<BrowseCategory> categories = await spotifyCategoryRepo.getSeveralBrowseCategories(limit:limit,offset:offset);
      emit(CategoriesLoaded(categories: categories));
    }
    catch(e){
      emit(CategoryError(message:e.toString()));
    }
  }

  Future<void> getSingleBrowseCategory({required String categoryId})async{
    emit(CategoryLoading());
    try{
      final BrowseCategory category = await spotifyCategoryRepo.getSingleBrowseCategory(categoryId: categoryId);
      emit(CategoryLoaded(category: category));
    }
    catch(e){
      emit(CategoryError(message:e.toString()));
    }
  }
}