import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:spotify_dribble/core/components/sections/window_title_bar.dart';
import 'package:spotify_dribble/features/home/presentation/home_section.dart';

class OldHomePage extends StatefulWidget {
  const OldHomePage({super.key});

  @override
  State<OldHomePage> createState() => _HomePageState();
}

class _HomePageState extends State<OldHomePage> {

  int count = 0;
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
          Expanded(child:HomeSection())
        ],
      ),
    );
  }
}
