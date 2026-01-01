import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:spotify_dribble/core/models/page_data.dart';
import 'package:spotify_dribble/core/player/presentation/cubit/player_cubit.dart';
import 'package:spotify_dribble/core/player/presentation/cubit/player_states.dart';
import 'package:spotify_dribble/features/artist/domain/model/artist_simplified.dart';
import 'package:spotify_dribble/features/track/domain/model/track.dart';
import 'package:spotify_dribble/core/components/widgets/hover_title.dart';

class PlayerDisplayPage extends StatefulWidget {
  const PlayerDisplayPage({super.key});

  @override
  State<PlayerDisplayPage> createState() => _PlayerDisplayPageState();
}

class _PlayerDisplayPageState extends State<PlayerDisplayPage>
    with SingleTickerProviderStateMixin {
  late Animation<double> fadeAnimation;
  late Animation<double> enlargeAnimation;
  late AnimationController animationController;
  String? lastTrackid;
  double dx = 0;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    fadeAnimation = Tween<double>(
      begin: 0,
      end: 0.8,
    ).animate(animationController);
    enlargeAnimation = Tween<double>(
      begin: 400,
      end: 500,
    ).animate(animationController);
    animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: BlocConsumer<PlayerCubit, PlayerStates>(
        listenWhen: (previous, current) {
          print("Previous Player State : $previous");
          print("Current Player State : $current");
          if (current is PlayerLoaded && current.playbackState != null) {
            final id = current.playbackState?.playerItem?.track?.id;
            return id != null && id != lastTrackid;
          }
          return false;
        },
        listener: (context, state) {
          if (state is PlayerLoaded) {
            lastTrackid = state.playbackState!.playerItem!.track!.id;
            animationController
              ..reset()
              ..forward();
          }
        },
        builder: (context, state) {
          if (state is PlayerLoaded) {
            if (state.playbackState != null &&
                state.playbackState!.playerItem != null) {
              final Track track = state.playbackState!.playerItem!.track!;
              final bool playbackState = state.playbackState!.isPlaying;
              final List<String> artists = List.generate(
                track.artists.length,
                (index) => track.artists[index].name,
              );

              // final PageData pageData = PageData(trackAlbum: track.album);

              return GestureDetector(
                onTap: () {
                  if (playbackState) {
                    context.read<PlayerCubit>().pause();
                  } else {
                    context.read<PlayerCubit>().resume();
                  }
                },
                onHorizontalDragUpdate: (details) {
                  dx += details.delta.dx;
                },
                onHorizontalDragEnd: (detials) {
                  if (detials.primaryVelocity! > 50) {
                    context.read<PlayerCubit>().next();
                  }
                  if (detials.primaryVelocity! < -50) {
                    context.read<PlayerCubit>().previous();
                  }
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned.fill(
                      child: FadeTransition(
                        opacity: fadeAnimation,
                        child: Container(
                          clipBehavior: Clip.hardEdge,
                          padding: EdgeInsets.zero,
                          margin: EdgeInsets.zero,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                track.album.images[0].imageUrl,
                              ),
                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                            ),
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                              color: Theme.of(context).colorScheme.primary,
                              style: BorderStyle.solid,
                              width: 1,
                            ),
                          ),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 35, sigmaY: 20),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () => Navigator.of(context).pop(),
                                icon: Icon(Icons.arrow_back),
                              ),
                              HoverTitle(
                                title: track.album.name, 
                                fontSize: 25, 
                                onTap: ()=>print("get pranked idiot"), 
                                color: Theme.of(context).colorScheme.primary,
                                weight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                              ),
                              IconButton(
                                onPressed: () => print("queue"),
                                icon: Icon(Icons.queue_music_outlined),
                              ),
                            ],
                          ),
                        ),
                        AnimatedBuilder(
                          animation: enlargeAnimation,
                          builder: (context, child) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                boxShadow: [
                                  BoxShadow(
                                    spreadRadius: 10,
                                    blurRadius: 20,
                                    blurStyle: BlurStyle.normal,
                                    color: Theme.of(context).colorScheme.primary
                                        .withValues(alpha: 0.2),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadiusGeometry.circular(50),
                                child: Image.network(
                                  track.album.images[0].imageUrl,
                                  height: enlargeAnimation.value,
                                  width: enlargeAnimation.value,
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 30),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.music_note,
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 30,
                                ),
                                SizedBox(width: 10),
                                HoverTitle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 30,
                                  title: track.name,
                                  onTap: () => print("help i am being touched"),
                                  weight: FontWeight.bold,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(track.artists.length, (index) {
                                if (artists.length==1||(index+1)==artists.length) {
                                  final ArtistSimplified artist = track.artists[index];
                                  final PageData pageData = PageData(
                                    artistSimplified: artist
                                  );
                                  return Row(
                                    children: [
                                      SizedBox(
                                        width:5,
                                      ),
                                      HoverTitle(
                                        title: artist.name,
                                        fontSize: 16,
                                        onTap: () => Navigator.pushNamed(context, '/artist',arguments:pageData),
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                      ),
                                    ],
                                  );
                                } else {
                                  return Row(
                                    children: [
                                      SizedBox(width:5),
                                      HoverTitle(
                                        title: artists[index],
                                        fontSize: 16,
                                        onTap: () => print("get a like retard"),
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                      ),
                                      Text(
                                        ",",
                                        style: TextStyle(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.primary,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  );
                                }
                              }),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            } else {
              return Text(
                "No Playback Currently Available",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              );
            }
          } else if (state is PlayerError) {
            return Text(
              state.message,
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 18,
              ),
            );
          } else {
            return Shimmer.fromColors(
              baseColor: Theme.of(
                context,
              ).colorScheme.primary.withValues(alpha: 0.3),
              highlightColor: Colors.grey.shade800.withValues(alpha: 0.3),
              child: Container(
                clipBehavior: Clip.hardEdge,
                margin: EdgeInsets.zero,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
