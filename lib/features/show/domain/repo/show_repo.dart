import 'package:spotify_dribble/features/show/domain/model/show.dart';

abstract class ShowRepo {
  Future<Show> getShow({required String id});
  
}