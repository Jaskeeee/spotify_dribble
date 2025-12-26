import 'package:flutter/material.dart';
import 'package:spotify_dribble/core/models/page_data.dart';

class PlayerDisplayPage extends StatefulWidget {
  final PageData pageData;
  const PlayerDisplayPage({
    super.key,
    required this.pageData
  });

  @override
  State<PlayerDisplayPage> createState() => _PlayerDisplayPageState();
}

class _PlayerDisplayPageState extends State<PlayerDisplayPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("player display page lol"),
    );
  }
}