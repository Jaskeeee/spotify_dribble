import 'package:flutter/material.dart';
import 'package:spotify_dribble/core/components/sections/window_title_bar.dart';
import 'package:spotify_dribble/core/constants/constants.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
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
              child: Image.asset(lighLogoPath, width: 40, height: 40),
            ),
          ),
          Expanded(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(150, 100, 150, 0),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                          ),
                          border: Border.all(
                            style: BorderStyle.solid,
                            color: Colors.grey.shade400.withValues(alpha: 0.3),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(150, 0, 150, 100),
                        padding: EdgeInsets.all(30),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade700.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50),
                          ),
                          border: Border.all(
                            style: BorderStyle.solid,
                            color: Colors.grey.shade400.withValues(alpha: 0.3),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // Carousel centered in the white (top) container
              
              ],
            ),
          ),
        ],
      ),
    );
  }
}
