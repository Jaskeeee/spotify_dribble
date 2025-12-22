import 'package:flutter/material.dart';

final String darkLogoPath = "assets/images/Spotify_Primary_Logo_RGB_Black.png";
final String lightLogoPath = "assets/images/Spotify_Primary_Logo_RGB_White.png";
final String spotifyLogoPath = "assets/images/Spotify_Primary_Logo_RGB_Green.png";

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();
final Map<String,IconData> deviceTypes = {
  "Speaker":Icons.speaker,
  "Computer":Icons.computer_rounded,
  "Smartphone":Icons.smartphone
};

