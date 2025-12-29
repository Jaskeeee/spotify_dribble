import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:spotify_dribble/core/auth/domain/model/spotify_user.dart';
import 'package:spotify_dribble/core/components/sections/player_section.dart';
import 'package:spotify_dribble/core/components/sections/window_title_bar.dart';
import 'package:spotify_dribble/core/components/widgets/section_button.dart';
import 'package:spotify_dribble/core/constants/app_constants.dart';
import 'package:spotify_dribble/core/models/page_data.dart';
import 'package:spotify_dribble/core/player/presentation/pages/player_display_page.dart';
import 'package:spotify_dribble/features/album/presentation/pages/album_page.dart';
import 'package:spotify_dribble/features/home/presentation/pages/browse_page.dart';

class HomePage extends StatefulWidget {
  final SpotifyUser? user;
  const HomePage({super.key, required this.user});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with RouteAware{
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  String currentPage = '/';
  @override
  Widget build(BuildContext context) {
    final String routeName = ModalRoute.of(context)?.settings.name ?? '/none'; 
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        clipBehavior: Clip.none,
        child: Column(
          children: [
            WindowTitleBar(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Icon(Bootstrap.spotify, color: Colors.white, size: 30),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 20),
              padding: EdgeInsets.only(left:10,right:10),
              height: 80,
              clipBehavior: Clip.none,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: Theme.of(context).colorScheme.secondary,
                ),
                color: Theme.of(
                  context,
                ).colorScheme.primary.withValues(alpha: 0.3),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: 
                [
                SectionButton(
                  iconData: Icons.play_circle, 
                  title: "Listen Now",
                  buttonRouteName: '/listen',
                  routeName: currentPage,
                  onTap: (){
                    navigatorKey.currentState?.pushReplacementNamed('/listen',);
                    setState(() {
                      currentPage='/listen';
                    });
                  },
                ),
                SectionButton(
                  iconData: Icons.layers, 
                  title: "Browse",
                  buttonRouteName: '/',
                  routeName: currentPage,
                  onTap: (){
                    navigatorKey.currentState?.pushReplacementNamed('/');
                    setState(() {
                      currentPage='/';
                    });
                  }
                ),
                SectionButton(
                  iconData: Icons.play_circle, 
                  title: "Listen Now",
                  routeName: routeName,
                  buttonRouteName:'radio',
                  onTap: (){}
                ),
                SectionButton(
                  iconData: Icons.music_note, 
                  title: "Playlists",
                  routeName: routeName,
                  buttonRouteName: 'playlists',
                  onTap: (){}
                ),
              ]),
            ),
            Stack(
              alignment: Alignment.bottomCenter,
              clipBehavior: Clip.none,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(150, 0, 150, 95),
                  width: double.infinity,
                  height: 810,
                  clipBehavior: Clip.none,
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                ),
                child: ClipRect(
                  clipBehavior: Clip.none,
                  child: Navigator(
                    key: navigatorKey,
                    clipBehavior: Clip.none,
                    initialRoute: '/',
                    observers: [routeObserver],
                    onGenerateRoute: (settings){
                      return MaterialPageRoute(
                        builder: (context){
                          final PageData pageData= settings.arguments as PageData? ?? PageData(user:widget.user);
                          switch(settings.name){
                            case('/album'):
                            return AlbumPage(pageData: pageData);
                            case('/listen'):
                            return PlayerDisplayPage();
                            default:
                            return Material(
                              type: MaterialType.transparency,
                              child: ClipRRect(
                                clipBehavior: Clip.none,
                                child: BrowsePage(pageData:pageData,)
                                ),
                            );
                          }
                        }
                      );
                    },
                  ),
                )
                ),
                PlayerSection(
                  navKey: navigatorKey,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
