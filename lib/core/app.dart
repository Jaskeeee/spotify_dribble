import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_dribble/core/constants/app_constants.dart';
import 'package:spotify_dribble/core/player/data/spotify_player_repo.dart';
import 'package:spotify_dribble/core/player/presentation/cubit/device_cubit.dart';
import 'package:spotify_dribble/core/player/presentation/cubit/player_cubit.dart';
import 'package:spotify_dribble/core/themes/themes.dart';
import 'package:spotify_dribble/features/album/data/spotify_album_repo.dart';
import 'package:spotify_dribble/features/album/presentation/cubit/album_cubit.dart';
import 'package:spotify_dribble/features/home/presentation/pages/home_page.dart';
import 'package:spotify_dribble/features/track/data/spotify_track_repo.dart';
import 'package:spotify_dribble/features/track/presentation/cubit/track_cubit.dart';

class App extends StatelessWidget{
  final SpotifyPlayerRepo spotifyPlayerRepo = SpotifyPlayerRepo();
  final SpotifyAlbumRepo spotifyAlbumRepo = SpotifyAlbumRepo();
  final SpotifyTrackRepo spotifyTrackRepo = SpotifyTrackRepo();
  App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider>[
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
        )
      ],
      child: MaterialApp(
        theme: lightTheme,
        navigatorObservers: [routeObserver],
        debugShowCheckedModeBanner: false,
        home: HomePage(),  
      ),
    );
  }
}