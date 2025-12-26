import 'package:flutter/material.dart';
import 'package:spotify_dribble/core/models/image_model.dart';

class CategoryTile extends StatelessWidget {
  final String id;
  final String name;
  final List<ImageModel> icons;
  const CategoryTile({
    super.key,
    required this.icons,
    required this.id,
    required this.name
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minTileHeight: 80,
      contentPadding: EdgeInsets.zero,
      minLeadingWidth: 100,
      leading: Image.network(
        icons[0].imageUrl,
        width: 80,
        height: 80
      ),
      title:Text(
        name,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary, 
          fontSize: 18,
        ),
      ),
      titleAlignment: ListTileTitleAlignment.center,
    );
  }
}