import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_dribble/core/auth/data/spotify_oauth_pkce.dart';
import 'package:spotify_dribble/core/auth/data/spotify_user_repo.dart';
import 'package:spotify_dribble/core/components/sections/player_section.dart';
import 'package:spotify_dribble/core/player/data/spotify_player_repo.dart';
import 'package:spotify_dribble/core/player/domain/model/device.dart';
import 'package:spotify_dribble/core/player/presentation/cubit/player_cubit.dart';
import 'package:spotify_dribble/features/album/data/spotify_album_repo.dart';
import 'package:spotify_dribble/features/album/domain/model/album.dart';
import 'package:spotify_dribble/features/artist/domain/model/artist.dart';
import 'package:spotify_dribble/features/track/data/spotify_track_repo.dart';
import 'package:spotify_dribble/features/track/domain/model/track.dart';
import 'package:spotify_dribble/features/track/domain/model/track_simplified.dart';

class HomeSection extends StatefulWidget {
  const HomeSection({super.key});

  @override
  State<HomeSection> createState() => _HomeSectionState();
}

class _HomeSectionState extends State<HomeSection> {
  final SpotifyOauthPkce spotifyOauthPkce = SpotifyOauthPkce();
  final SpotifyUserRepo spotifyUserRepo = SpotifyUserRepo();
  final SpotifyPlayerRepo spotifyPlayerRepo = SpotifyPlayerRepo();
  final SpotifyAlbumRepo albumRepo = SpotifyAlbumRepo();
  final SpotifyTrackRepo trackRepo = SpotifyTrackRepo();
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  style: BorderStyle.solid,
                  color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.3),
                ),
              ),
              margin: EdgeInsets.fromLTRB(150, 100, 150, 100),
              alignment: Alignment.center,
              child: Column(
                children: [
                  TextButton(
                    onPressed: () async {
                      await spotifyOauthPkce.requestUserAuthorization();
                    },
                    child: Text("Request User auth"),
                  ),
                  TextButton(
                    onPressed: () async {
                      await spotifyOauthPkce.requestAccessToken();
                    },
                    child: Text("Request User Access Token"),
                  ),
                  TextButton(
                    onPressed: () async {
                      await spotifyOauthPkce.logOut();
                    },
                    child: Text("Delete Credentials"),
                  ),
                  TextButton(
                    onPressed: () async {
                      await spotifyPlayerRepo.shuffle(state: true);
                    },
                    child: Text(
                      "Shuffle",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      final String deviceId = "ba2f50a926161c744c92d344d36d81428dc52932";
                      await spotifyPlayerRepo.transferPlayback(
                        deviceIds: [deviceId],
                      );
                    },
                    child: Text(
                      "Transfer PLayback to phone",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      final List<Device> devices = await spotifyPlayerRepo
                          .getavailableDevices();
                      print("Devices");
                      for (Device device in devices) {
                        print("Name: ${device.name} id: ${device.id}");
                      }
                    },
                    child: Text(
                      "get available devices",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      await spotifyPlayerRepo.pause();
                    },
                    child: Text(
                      "Pause",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      await spotifyPlayerRepo.resume();
                    },
                    child: Text(
                      "Resume",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      await spotifyPlayerRepo.next();
                    },
                    child: Text(
                      "Next",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      await spotifyPlayerRepo.previous();
                    },
                    child: Text(
                      "Previous",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      await spotifyPlayerRepo.seek(positionMs: 5000);
                    },
                    child: Text(
                      "Seek 5s",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      final List<Artist> followedArtist =
                          await spotifyUserRepo.getFollowedArtists();
                      for (Artist artist in followedArtist) {
                        print(artist.name);
                      }
                    },
                    child: Text(
                      "Followed Artist",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      await spotifyPlayerRepo.volume(volume: 20);
                    },
                    child: Text(
                      "Volume set 20",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      await spotifyPlayerRepo.queue(
                        uri: "spotify:track:4iV5W9uYEdYUVa79Axb7Rh",
                      );
                    },
                    child: Text(
                      "Queue this spotify:track:4iV5W9uYEdYUVa79Axb7Rh",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      final List<Album> albums = await albumRepo
                          .getUserSavedAlbums();
                      if (albums.isNotEmpty) {
                        for (var album in albums) {
                          print("${album.name}:${album.id}");
                        }
                      } else {
                        print("user albums not found");
                      }
                    },
                    child: Text(
                      "Get User Album baby",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      await spotifyPlayerRepo.syncDevice();
                    },
                    child: Text(
                      "sync device",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      final String id = "1k7OXnGQPV4zF3seDwRroD";
                      // final String id = "spotify:album:1k7OXnGQPV4zF3seDwRroD";
                      final List<TrackSimplified> tracks = await albumRepo
                          .getAlbumTracks(id: id);
                      for (TrackSimplified track in tracks) {
                        print("Name:${track.name} Id: ${track.id}");
                      }
                    },
                    child: Text(
                      "Track to Post Human Nex Gen",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      final List<String> ids = [
                        '1XkGORuUX2QGOEIL4EbJKm',
                        '2knEuvsxqHMAoxlQpIdpQD',
                      ];
                      final List<Album> albums = await albumRepo.getAlbums(
                        ids: ids,
                      );
                      for (Album album in albums) {
                        print(album.name);
                      }
                    },
                    child: Text(
                      "luvish saikia",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      final List<Track> topTracks = await spotifyPlayerRepo
                          .getRecentlyPlayedTracks();
                      for (Track track in topTracks) {
                        print("Track:${track.name} ID: ${track.uri}");
                      }
                    },
                    child: Text(
                      "User Top Tracks",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      await spotifyPlayerRepo.startPlayback(
                        uris: ["spotify:track:7u83tMqc2n4L1FuShWTqGH"],
                        // deviceId: "23e6e39f692d8ad30d68c9a248b20c2ff6ce2596",
                      );
                    },
                    child: Text(
                      "Start Playback",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  TextButton(
                    onPressed: ()=>context.read<PlayerCubit>().getPlaybackState(), 
                    child: Text(
                      "Get playback state",
                      style: TextStyle(
                        color: Colors.white
                      ),
                    )
                  ),
                  TextButton(
                    onPressed: ()async{
                      final List<Track> tracks = await trackRepo.getUserSavedTracks(limit:50,offset:49);
                      print(tracks.length);
                      for(Track track in tracks){
                        print("Name ${track.name} Album: ${track.album.name}");
                      }
                    }, 
                    child: Text(
                      "Get My Tracksss",
                      style: TextStyle(
                        color: Colors.white
                      ),
                    )
                  )
                ],
              ),
            ),
            PlayerSection()
          ],
        ),
      ),
    );
  }
}
