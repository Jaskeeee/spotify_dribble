import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_dribble/core/components/widgets/loading_tile_widget.dart';
import 'package:spotify_dribble/features/album/domain/model/album.dart';
import 'package:spotify_dribble/features/album/presentation/cubit/album_cubit.dart';
import 'package:spotify_dribble/features/album/presentation/cubit/album_states.dart';
import 'package:spotify_dribble/features/home/presentation/components/widget/track_tile.dart';
import 'package:spotify_dribble/features/track/domain/model/track_simplified.dart';

class AlbumTracks extends StatefulWidget {
  final Album album;
  const AlbumTracks({super.key, required this.album});

  @override
  State<AlbumTracks> createState() => _AlbumTracksState();
}

class _AlbumTracksState extends State<AlbumTracks> {
  @override
  void initState() {
    context.read<AlbumCubit>().getAlbumTracks(
      id: widget.album.id,
      limit: widget.album.totalTracks <= 50 ? widget.album.totalTracks : 50,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(25, 20, 25, 0),
        child: BlocBuilder<AlbumCubit, AlbumStates>(
          builder: (context, state) {
            if (state is AlbumTracksLoaded) {
              if (state.tracks.isNotEmpty) {
                return ListView.builder(
                  itemCount: state.tracks.length,
                  itemBuilder: (context, index) {
                    final TrackSimplified trackSimplified = state.tracks[index];
                    if (index ==(state.tracks.length + 1)) {
                      return SizedBox(
                        height: 30,
                      );
                    }else {
                      return SizedBox(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 25,
                              child: Text(
                                (index + 1).toString(),
                                style: TextStyle(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.secondary,
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(width: 30),
                            Expanded(
                              child: TrackTile(
                                uri: trackSimplified.uri,
                                coverArt: widget.album.images[0],
                                duration: trackSimplified.durationMs,
                                artists: trackSimplified.artists,
                                title: trackSimplified.name,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                );
              } else {
                return Center(child: Text("No Tracks found!"));
              }
            } else if (state is AlbumError) {
              return Center(
                child: Text(
                  state.message,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 18,
                  ),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) => LoadingTileWidget(),
              );
            }
          },
        ),
      ),
    );
  }
}
