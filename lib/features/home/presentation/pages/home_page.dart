import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:spotify_dribble/core/app/app_navigator.dart';
import 'package:spotify_dribble/core/auth/domain/model/spotify_user.dart';
import 'package:spotify_dribble/core/components/sections/player_section.dart';
import 'package:spotify_dribble/core/components/sections/window_title_bar.dart';
import 'package:spotify_dribble/core/components/widgets/section_button.dart';

class HomePage extends StatefulWidget {
  final SpotifyUser? user;
  const HomePage({
    super.key,
    required this.user,
  });
  @override
  State<HomePage> createState() => _NewHomePageState();
}
class _NewHomePageState extends State<HomePage>with RouteAware{
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  String currentPage = '/';
  @override
  Widget build(BuildContext context) {
    final String routeName = ModalRoute.of(context)?.settings.name ?? '/none'; 
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              WindowTitleBar(
                child:Container(
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
                border: Border.all(color: Theme.of(context).colorScheme.secondary),
                color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
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
              Expanded(
                child: Container(
                  margin: EdgeInsets.fromLTRB(150,0,100,100),
                  clipBehavior: Clip.none,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Theme.of(context).colorScheme.secondary),
                    color: Theme.of(context).colorScheme.primary.withValues(alpha:0.3),
                  ),
                  child: ClipRect(
                  clipBehavior: Clip.none,
                  child: AppNavigator(
                    user:widget.user, 
                    navigatorKey: navigatorKey
                  ),
                ),
                ),
              ),
            ],
          ),
          PlayerSection(
            navKey: navigatorKey,
          )
        ],
      ),
    );
  }
}