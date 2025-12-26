import 'package:flutter/material.dart';
import 'package:spotify_dribble/core/models/image_model.dart';

class PlaylistTile extends StatelessWidget {
  final String uri;
  final String title;
  final List<ImageModel> coverArt;
  const PlaylistTile({
    super.key,
    required this.coverArt,
    required this.title,
    required this.uri
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      minLeadingWidth: 80,
      minTileHeight: 80,
      leading: coverArt.isNotEmpty
      ?ClipRRect(
        borderRadius: BorderRadiusGeometry.circular(10),
        child: AspectRatio(
          aspectRatio: 1,
          child: Image.network(
            coverArt[0].imageUrl,
            fit: BoxFit.cover,
            width: 80,
            height: 80,
          ),
        ),
      )
      :Icon(
        Icons.photo_size_select_actual_rounded,
        color: Theme.of(context).colorScheme.primary,
        size: 60,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18, 
          color: Colors.white
        ),
        overflow: TextOverflow.ellipsis,
      ),
      titleAlignment: ListTileTitleAlignment.center,
    );
  }
}