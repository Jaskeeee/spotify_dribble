import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_dribble/core/auth/data/spotify_user_repo.dart';
import 'package:spotify_dribble/core/auth/domain/model/spotify_user.dart';
import 'package:spotify_dribble/core/auth/presentation/cubit/auth_states.dart';

class AuthCubit extends Cubit<AuthStates>{
  final SpotifyUserRepo spotifyUserRepo;
  AuthCubit(
    {
      required this.spotifyUserRepo
    }
  ):super(AuthInitial());

  Future<void> getCurrentUser()async{
    try{
      final SpotifyUser? user = await spotifyUserRepo.getCurrentUserProfile();
      if(user!=null){
        emit(Authenticated(user: user));
      }else{
        emit(Unauthenticated());
      }
    }
    catch(e){
      emit(AuthError(message: e.toString()));
    }
  }
}