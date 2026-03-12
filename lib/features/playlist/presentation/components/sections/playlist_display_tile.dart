import 'package:flutter/material.dart';
import 'package:spotify_dribble/features/playlist/domain/model/playlist_simplified.dart';
import 'package:spotify_dribble/features/playlist/presentation/components/widgets/playlist_cover_art.dart';

class PlaylistDisplayTile extends StatelessWidget {
  final PlaylistSimplified playlist;
  const PlaylistDisplayTile({
    super.key,
    required this.playlist
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisSize: MainAxisSize.min,
      children: [
        PlaylistCoverArt(
          imageUrl: playlist.images[0].imageUrl,
        ),
        SizedBox(width:20),
        Expanded(
          child:Text(
            playlist.name,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
              fontSize: 26
            ),
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}