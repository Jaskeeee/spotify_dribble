import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_dribble/core/constants/app_constants.dart';
import 'package:spotify_dribble/core/models/page_data.dart';
import 'package:spotify_dribble/core/player/presentation/cubit/player_cubit.dart';
import 'package:spotify_dribble/features/album/presentation/components/sections/album_carousel.dart';
import 'package:spotify_dribble/features/album/presentation/cubit/album_cubit.dart';
import 'package:spotify_dribble/features/home/presentation/components/sections/user_liked_songs.dart';
import 'package:spotify_dribble/features/home/presentation/components/sections/spotify_recommendations.dart';
import 'package:spotify_dribble/features/home/presentation/pages/browsing_header.dart';

class BrowsePage extends StatefulWidget {
  final PageData pageData;
  const BrowsePage({super.key, required this.pageData});
  @override
  State<BrowsePage> createState() => _BrowsePageState();
}

class _BrowsePageState extends State<BrowsePage>with RouteAware,SingleTickerProviderStateMixin{
  double currentSliderValue = 20;
  double currentDiscretesliderValue = 60;

  @override
  void initState() {
    context.read<PlayerCubit>().getPlaybackState();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this,ModalRoute.of(context)!as PageRoute);
  }

  @override
  void didPopNext() {
    context.read<AlbumCubit>().getUserSavedAlbums();
    super.didPopNext();
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 1,          
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Column(
                  children: [
                    BrowsingHeader(user:widget.pageData.user), 
                    Spacer()
                  ]),
                Positioned(
                  top: 90,
                  left: -120,
                  right: -120,
                  child: AlbumCarousel(),
                ),
              ],
            ),
          ),
        ),
        Flexible(
          flex: 1,
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              // mainAxisSize: MainAxisSize.min,
              children: [
                UserLikedSongs(),
                SizedBox(width: 10),
                SpotifyRecommendations(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
