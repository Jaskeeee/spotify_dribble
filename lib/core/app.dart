import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_dribble/core/player/data/spotify_player_repo.dart';
import 'package:spotify_dribble/core/player/presentation/cubit/device_cubit.dart';
import 'package:spotify_dribble/core/player/presentation/cubit/player_cubit.dart';
import 'package:spotify_dribble/core/themes/themes.dart';
import 'package:spotify_dribble/features/home/presentation/pages/home_page.dart';

class App extends StatelessWidget{
  final SpotifyPlayerRepo spotifyPlayerRepo = SpotifyPlayerRepo();
  App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider>[
        BlocProvider<PlayerCubit>(
          create:(context)=>PlayerCubit(spotifyPlayerRepo: spotifyPlayerRepo)
        ),
        BlocProvider<DeviceCubit>(
          create: (context)=>DeviceCubit(spotifyPlayerRepo: spotifyPlayerRepo)
        )
      ],
      child: MaterialApp(
        theme: lightTheme,
        debugShowCheckedModeBanner: false,
        home: HomePage(),  
      ),
    );
  }
}