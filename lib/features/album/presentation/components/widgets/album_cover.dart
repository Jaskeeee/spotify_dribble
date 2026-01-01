import 'package:flutter/material.dart';

class AlbumCover extends StatelessWidget {
  final String imageUrl;
  const AlbumCover({
    super.key,
    required this.imageUrl
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: 300,
      child: ClipRRect(
        borderRadius: BorderRadiusGeometry.circular(40),
        child: Image.network(imageUrl),
      ),
    );
  }
}
