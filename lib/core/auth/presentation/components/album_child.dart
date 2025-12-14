import 'package:flutter/material.dart';

class AlbumChild extends StatelessWidget {
  final String imageFile;
  const AlbumChild({
    super.key,
    required this.imageFile
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(20),
      child: Image.asset(imageFile, height: 300, width: 300),
    );
  }
}
