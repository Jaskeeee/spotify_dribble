import 'package:flutter/material.dart';

class PlaylistCoverArt extends StatelessWidget {
  final String imageUrl;
  const PlaylistCoverArt({
    super.key,
    required this.imageUrl,
  });
  

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20)
      ),
      child: Image.network(
        imageUrl,
        width: 200,
        height: 200,
        fit: BoxFit.cover,
      ),
    );
  }
}