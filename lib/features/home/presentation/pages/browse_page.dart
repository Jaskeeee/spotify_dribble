import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_dribble/core/components/sections/player_section.dart';
import 'package:spotify_dribble/core/player/data/spotify_player_repo.dart';
import 'package:spotify_dribble/core/player/presentation/cubit/player_cubit.dart';
import 'package:spotify_dribble/features/episode/data/spotify_episode_repo.dart';
import 'package:spotify_dribble/features/episode/domain/model/episode.dart';
import 'package:spotify_dribble/features/home/presentation/components/sections/user_liked_songs.dart';
import 'package:spotify_dribble/features/home/presentation/components/sections/user_playlist.dart';
import 'package:spotify_dribble/features/playlist/data/spotify_playlist_repo.dart';
import 'package:spotify_dribble/features/playlist/model/playlist.dart';
import 'package:spotify_dribble/features/playlist/model/playlist_simplified.dart';
import 'package:spotify_dribble/features/show/data/spotify_show_repo.dart';

class BrowsePage extends StatefulWidget {
  const BrowsePage({super.key});

  @override
  State<BrowsePage> createState() => _BrowsePageState();
}

class _BrowsePageState extends State<BrowsePage> {
  final SpotifyEpisodeRepo spotifyEpisodeRepo = SpotifyEpisodeRepo();
  final SpotifyShowRepo spotifyShowRepo = SpotifyShowRepo();
  final SpotifyPlaylistRepo spotifyPlaylistRepo = SpotifyPlaylistRepo();
  double currentSliderValue = 20;
  double currentDiscretesliderValue =60;
  @override
  void initState() {
    context.read<PlayerCubit>().getPlaybackState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(150,100, 150,100),
          width: double.infinity,
          height:810,
          clipBehavior: Clip.none,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: Theme.of(context).colorScheme.secondary
            ),
            color: Theme.of(context).colorScheme.primary.withValues(alpha:0.3)
          ),
          child: Column(
            children: [
              Container(
                height: 400,
                clipBehavior: Clip.none,
                child: TextButton(
                onPressed: ()async{
                    final List<PlaylistSimplified> playlists= await spotifyPlaylistRepo.getUserPlaylists(userId: "smedjan");
                    for(PlaylistSimplified playlist in playlists){
                      print(playlist.name);
                    }
                  }, 
                  child: Text("Fetch Playlist")
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50)
                    ),
                    color: Colors.black.withValues(alpha:0.3),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    UserLikedSongs(),
                    SizedBox(width: 10),
                    UserPlaylist()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        PlayerSection(),
      ],
    );
  }
}