import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_dribble/core/auth/data/spotify_user_repo.dart';
import 'package:spotify_dribble/core/auth/presentation/cubit/auth_cubit.dart';
import 'package:spotify_dribble/core/auth/presentation/pages/auth_page.dart';
import 'package:spotify_dribble/core/constants/app_constants.dart';
import 'package:spotify_dribble/core/player/data/spotify_player_repo.dart';
import 'package:spotify_dribble/core/player/presentation/cubit/device_cubit.dart';
import 'package:spotify_dribble/core/player/presentation/cubit/player_cubit.dart';
import 'package:spotify_dribble/core/themes/themes.dart';
import 'package:spotify_dribble/features/album/data/spotify_album_repo.dart';
import 'package:spotify_dribble/features/album/presentation/cubit/album_cubit.dart';
import 'package:spotify_dribble/features/artist/data/spotify_artist_repo.dart';
import 'package:spotify_dribble/features/artist/presentation/cubit/artist_cubit.dart';
import 'package:spotify_dribble/features/category/data/spotify_category_repo.dart';
import 'package:spotify_dribble/features/category/presentation/cubit/category_cubit.dart';
import 'package:spotify_dribble/features/playlist/data/spotify_playlist_repo.dart';
import 'package:spotify_dribble/features/playlist/presentation/cubit/playlist_cubit.dart';
import 'package:spotify_dribble/features/track/data/spotify_track_repo.dart';
import 'package:spotify_dribble/features/track/presentation/cubit/track_cubit.dart';

class App extends StatelessWidget{
  final SpotifyPlayerRepo spotifyPlayerRepo = SpotifyPlayerRepo();
  final SpotifyAlbumRepo spotifyAlbumRepo = SpotifyAlbumRepo();
  final SpotifyTrackRepo spotifyTrackRepo = SpotifyTrackRepo();
  final SpotifyPlaylistRepo spotifyPlaylistRepo = SpotifyPlaylistRepo();
  final SpotifyCategoryRepo spotifyCategoryRepo = SpotifyCategoryRepo();
  final SpotifyUserRepo spotifyUserRepo = SpotifyUserRepo();
  final SpotifyArtistRepo spotifyArtistRepo = SpotifyArtistRepo();
  App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider>[
        BlocProvider<AuthCubit>(
          create: (context)=>AuthCubit(spotifyUserRepo:spotifyUserRepo)..getCurrentUser()
        ),
        BlocProvider<TrackCubit>(
          create: (context)=>TrackCubit(spotifyTrackRepo: spotifyTrackRepo)
        ),
        BlocProvider<PlayerCubit>(
          create:(context)=>PlayerCubit(spotifyPlayerRepo: spotifyPlayerRepo)
        ),
        BlocProvider<DeviceCubit>(
          create: (context)=>DeviceCubit(spotifyPlayerRepo: spotifyPlayerRepo)
        ),
        BlocProvider<AlbumCubit>(
          create: (context)=>AlbumCubit(spotifyAlbumRepo: spotifyAlbumRepo)
        ),
        BlocProvider<PlaylistCubit>(
          create: (context)=>PlaylistCubit(spotifyPlaylistRepo: spotifyPlaylistRepo)
        ),
        BlocProvider<CategoryCubit>(
          create: (context)=>CategoryCubit(spotifyCategoryRepo: spotifyCategoryRepo),
        ),
        BlocProvider<ArtistCubit>(
          create: (context)=>ArtistCubit(spotifyArtistRepo: spotifyArtistRepo)
        )
      ],
      child: MaterialApp(
        theme: lightTheme,
        // navigatorObservers: [routeObserver],
        debugShowCheckedModeBanner: false,
        home: AuthPage(),  
      ),
    );
  }
}