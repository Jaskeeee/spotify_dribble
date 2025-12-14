import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_dribble/core/auth/data/spotify_oauth_pkce.dart';
import 'package:spotify_dribble/core/auth/data/spotify_user_repo.dart';
import 'package:spotify_dribble/core/auth/domain/model/access_token.dart';
import 'package:spotify_dribble/core/auth/domain/model/spotify_user.dart';
import 'package:spotify_dribble/core/auth/presentation/bloc/auth_events.dart';
import 'package:spotify_dribble/core/auth/presentation/bloc/auth_states.dart';

class AuthBloc extends Bloc<AuthEvents,AuthStates>{
  final SpotifyOauthPkce spotifyOauthPkce;
  final SpotifyUserRepo spotifyUserRepo;
  AuthBloc({
    required this.spotifyOauthPkce,
    required this.spotifyUserRepo
  }):super(AuthInitial()){
    on<RefresAccessToken>((event, emit)async{
      try{
        final AccessToken? accessToken = await spotifyOauthPkce.refreshAccessToken();
        if(accessToken!=null){
          final SpotifyUser? user = await spotifyUserRepo.getCurrentUserProfile();
          if(user!=null){
            emit(Authenticated(user: user));
          }else{
            emit(Unauthenticated());
          }
        }
      }catch(e){
        emit(AuthError(message: e.toString()));
      }
      
    });
  }
}