import 'package:flutter/material.dart';
import 'package:spotify_dribble/core/components/widgets/loading_tile_widget.dart';

class UserPlaylist extends StatefulWidget {
  const UserPlaylist({super.key});

  @override
  State<UserPlaylist> createState() => _UserPlaylistState();
}

class _UserPlaylistState extends State<UserPlaylist> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
          width: 2,
        ),
      ),
      height: 350,
      width: 800,
      child: LoadingTileWidget(),
    );
  }
}
