import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:spotify_dribble/core/auth/data/spotify_user_repo.dart';
import 'package:spotify_dribble/core/components/sections/window_title_bar.dart';
import 'package:spotify_dribble/core/constants/constants.dart';
import 'package:spotify_dribble/core/auth/data/spotify_oauth_pkce.dart';
import 'package:spotify_dribble/core/player/data/spotify_player_repo.dart';
import 'package:spotify_dribble/core/player/domain/model/playback_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final SpotifyOauthPkce spotifyOauthPkce = SpotifyOauthPkce();
  final SpotifyUserRepo spotifyUserRepo = SpotifyUserRepo();
  final SpotifyPlayerRepo spotifyPlayerRepo = SpotifyPlayerRepo();
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          WindowTitleBar(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40)
              ),
              child: Image.asset(
                lighLogoPath,
                width: 40,
                height: 40,
              ),
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX:10,sigmaY: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha:0.2),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      style: BorderStyle.solid,
                      color: Colors.grey.shade400.withValues(alpha:0.3)
                    )
                  ),
                  margin: EdgeInsets.fromLTRB(150,100,150,100),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      TextButton(
                        onPressed: ()async{
                          await spotifyPlayerRepo.shuffle(state:true);
                        }, 
                        child: Text(
                          "Shuffle",
                          style: TextStyle(
                            color: Colors.white
                          ),
                        )
                      ),
                      TextButton(
                        onPressed: ()async{
                          final String deviceId = "ba2f50a926161c744c92d344d36d81428dc52932";
                          await spotifyPlayerRepo.transferPlayback(deviceIds: [deviceId]);
                        }, 
                        child: Text(
                          "Transfer PLayback to phone",
                          style: TextStyle(
                            color: Colors.white
                          ),
                        )
                      ),
                      TextButton(
                        onPressed: ()async{
                          final devices = await spotifyPlayerRepo.getavailableDevices();
                          print(devices);
                        } ,
                        child: Text(
                          "get available devices",
                          style: TextStyle(
                            color: Colors.white
                          ),
                        )
                      ),
                      TextButton(
                        onPressed: ()async{
                          await spotifyPlayerRepo.pause();
                        }, 
                        child: Text(
                          "Pause",
                          style: TextStyle(
                            color: Colors.white
                          ),
                        )
                      ),
                      TextButton(
                        onPressed: ()async{
                          await spotifyPlayerRepo.resume();
                        }, 
                        child: Text(
                          "Resume",
                          style: TextStyle(
                            color: Colors.white
                          ),
                        )
                      ),
                      TextButton(
                        onPressed: ()async{
                          await spotifyPlayerRepo.next();
                        }, 
                        child: Text(
                          "Next",
                          style: TextStyle(
                            color: Colors.white
                          ),
                        )
                      ),
                      TextButton(
                        onPressed: ()async{
                          await spotifyPlayerRepo.previous();
                        }, 
                        child: Text(
                          "Previous",
                          style: TextStyle(
                            color: Colors.white
                          ),
                        )
                      ),
                      TextButton(
                        onPressed: ()async{
                          await spotifyPlayerRepo.seek(positionMs:5000);
                        }, 
                        child: Text(
                          "Seek 5s",
                          style: TextStyle(
                            color: Colors.white
                          ),
                        )
                      ),
                      TextButton(
                        onPressed:()async{
                          // await spotifyPlayerRepo.repeatMode(null,"track");
                        }, 
                        child: Text(
                          "Repeat",
                          style: TextStyle(
                            color: Colors.white
                          ),
                        )
                      ),
                      TextButton(
                        onPressed:()async{
                          await spotifyPlayerRepo.volume(volume:20);
                        }, 
                        child: Text(
                          "Volume set 20",
                          style: TextStyle(
                            color: Colors.white
                          ),
                        )
                      ),
                      TextButton(
                        onPressed:()async{
                          await spotifyPlayerRepo.queue(uri:"spotify:track:4iV5W9uYEdYUVa79Axb7Rh");
                        }, 
                        child: Text(
                          "Queue this spotify:track:4iV5W9uYEdYUVa79Axb7Rh",
                          style: TextStyle(
                            color: Colors.white
                          ),
                        )
                      ),
                      TextButton(
                        onPressed:()async{
                          final PlaybackState? playbackState = await spotifyPlayerRepo.getPlaybackState();
                          if(playbackState!=null){
                            print(playbackState.device);
                            print(playbackState.isPlaying);
                            print(playbackState.playerItem?.track?.name);
                            print(playbackState.progressMs);
                            print(playbackState.repeatState);
                            print(playbackState.shuffleState);
                            print(playbackState.timestamp);
                          }
                          else{
                            print("No playback available");
                          }
                        }, 
                        child: Text(
                          "Get Current Playback state",
                          style: TextStyle(
                            color: Colors.white
                          ),
                        )
                      )
                    ],
                  )
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
