import 'package:spotify_dribble/features/search/domain/model/search_item.dart';

abstract class SearchRepo {
  Future<SearchItem>search({required String q,int? limit,int? offset});
}