import 'package:flutter/material.dart';
import 'package:spotify_dribble/core/auth/domain/model/spotify_user.dart';
import 'package:spotify_dribble/core/constants/app_constants.dart';
import 'package:spotify_dribble/core/models/page_data.dart';
import 'package:spotify_dribble/core/player/presentation/pages/player_display_page.dart';
import 'package:spotify_dribble/features/album/presentation/pages/album_page.dart';
import 'package:spotify_dribble/features/artist/presentation/pages/artist_page.dart';
import 'package:spotify_dribble/features/home/presentation/pages/browse_page.dart';

class AppNavigator extends StatefulWidget {
  final SpotifyUser? user;
  final GlobalKey<NavigatorState> navigatorKey;
  const AppNavigator({
    super.key,
    required this.user,
    required this.navigatorKey,
  });

  @override
  State<AppNavigator> createState() => _AppNavigatorState();
}

class _AppNavigatorState extends State<AppNavigator> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: widget.navigatorKey,
      clipBehavior: Clip.none,
      initialRoute: '/',
      observers: [routeObserver],
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) {
            final PageData pageData=settings.arguments as PageData? ?? PageData(user: widget.user);
            switch (settings.name) {
              case ('/album'):
                return AlbumPage(pageData: pageData);
              case ('/listen'):
                return PlayerDisplayPage();
              case ('/artist'):
                return ArtistPage(pageData: pageData);
              default:
                return BrowsePage(pageData: pageData);
            }
          },
        );
      },
    );
  }
}
