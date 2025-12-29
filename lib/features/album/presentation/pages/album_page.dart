import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_dribble/core/constants/app_constants.dart';
import 'package:spotify_dribble/core/models/page_data.dart';
import 'package:spotify_dribble/features/album/domain/model/album.dart';
import 'package:spotify_dribble/features/album/domain/model/album_track.dart';
import 'package:spotify_dribble/features/album/presentation/components/widgets/album_play_button.dart';
import 'package:spotify_dribble/features/album/presentation/components/sections/album_tracks.dart';
import 'package:spotify_dribble/features/artist/presentation/components/artist_avatar.dart';
import 'package:spotify_dribble/features/artist/presentation/cubit/artist_cubit.dart';

class AlbumPage extends StatefulWidget {
  final PageData pageData;
  const AlbumPage({super.key, required this.pageData});

  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> with RouteAware {
  @override
  void didChangeDependencies() {
    routeObserver.subscribe(this, ModalRoute.of(context)! as PageRoute);
    super.didChangeDependencies();
  }

  @override
  void didPopNext() {
    context.read<ArtistCubit>().getArtist(
      id: widget.pageData.album?.artists[0].id ?? widget.pageData.trackAlbum!.artists[0].id,
    );
    super.didPopNext();
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  int calculateDuration(List<AlbumTrack> tracks) {
    int duration = 0;
    for (AlbumTrack track in tracks) {
      duration += track.durationMs;
    }
    return duration;
  }

  @override
  Widget build(BuildContext context) {
    final Album album = widget.pageData.album!;
    final Duration albumDuration = Duration(
      milliseconds: calculateDuration(album.tracks),
    );
    return SizedBox(
      height: 350,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              // Positioned.fill(
              //   child: Container(
              //     clipBehavior: Clip.hardEdge,
              //     decoration: BoxDecoration(
              //       borderRadius:const BorderRadius.only(
              //         topLeft: Radius.circular(50),
              //         topRight: Radius.circular(50)
              //       ),
              //       image: DecorationImage(
              //         image: NetworkImage(
              //           album.images[0].imageUrl,
              //         ),
              //         fit:BoxFit.cover
              //       )
              //     ),
              //     child: BackdropFilter(
              //       filter:ImageFilter.blur(
              //         sigmaX: 20,sigmaY: 20
              //       ),
              //       child: Container(
              //         color: Colors.transparent,
              //       ),
              //     ),
              //   ),
              // ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 30, top: 10),
                          child: IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: Icon(Icons.arrow_back),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(60, 20, 60, 20),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 300,
                          width: 300,
                          child: ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(40),
                            child: Image.network(album.images[0].imageUrl),
                          ),
                        ),
                        SizedBox(width: 40),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 20),
                              child: Text(
                                album.name,
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 50,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Row(
                                children: [
                                  ArtistAvatar(
                                    artistId: album.artists[0].id,
                                    titleColor: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "${album.totalTracks} songs,",
                                    style: TextStyle(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.secondary,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "${albumDuration.inHours}hr ${(albumDuration.inMinutes) % 60}min",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.secondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            AlbumPlayButton(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.zero,
              margin: EdgeInsets.zero,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
                color: Colors.black.withValues(alpha: 0.3),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [AlbumTracks(album: album)],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
