import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:spotify_dribble/core/components/sections/window_title_bar.dart';
import 'package:spotify_dribble/core/constants/app_constants.dart';

class UserAuthorizationPage extends StatelessWidget {
  const UserAuthorizationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          WindowTitleBar(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
              ),
              child: Icon(
                Bootstrap.spotify,
                color: Colors.white,
                size:30,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(150, 100, 150, 100),
            width: double.infinity,
            height: 810,
            clipBehavior: Clip.none,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: Theme.of(context).colorScheme.secondary),
              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        lightLogoPath,
                        width: 80,
                        height: 80,
                      ),
                      SizedBox(width: 20),
                      Text(
                        "Spotify",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 40
                        ),
                      )
                    ],
                  ),
                  SizedBox(height:30),
                  Text(
                    "Please grant the app premissions for to link to your Spotify Account.",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextButton(
                    onPressed: () => print("object"),
                    child: Container(
                      width: 300,
                      padding: EdgeInsets.fromLTRB(20,10,20,10),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(25)
                      ),
                      child: Center(
                        child: Text(
                          "Connect",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 25
                          ),
                        ),
                      ),
                    )
                  )

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
