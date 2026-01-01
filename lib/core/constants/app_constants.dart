import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
final String darkLogoPath = "assets/images/Spotify_Primary_Logo_RGB_Black.png";
final String lightLogoPath = "assets/images/Spotify_Primary_Logo_RGB_White.png";
final String spotifyLogoPath = "assets/images/Spotify_Primary_Logo_RGB_Green.png";

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();
final Map<String,IconData> deviceTypes = {
  "Speaker":Icons.speaker,
  "Computer":Icons.computer_rounded,
  "Smartphone":Icons.smartphone
};
final Map<String,Color> repeatColors = {
  "context":Colors.green,
  "track":Colors.blue,
  "off":Colors.white,
};

final LinearGradient shader = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  stops: [0.0,0.1,0.9, 1.0],
  colors: [
    Colors.white,
    Colors.transparent,
    Colors.transparent,
    Colors.white,
  ],
);
final List<IconData> albumMenuItems=[
  Icons.format_list_bulleted_add,
  Icons.favorite,
  BoxIcons.bxs_playlist
];

final List<String> albumMenuItemsTitle= [
  "Add to queue",
  "Add to your Library",
  "Add to Playlist"
];