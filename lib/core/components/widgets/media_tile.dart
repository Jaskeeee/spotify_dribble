import 'dart:math';

import 'package:flutter/material.dart';
import 'package:spotify_dribble/core/models/image_model.dart';

class MediaTile extends StatelessWidget {
  final String title;
  final List<ImageModel> leading;
  const MediaTile({
    super.key,
    required this.leading,
    required this.title
  });

  @override
  Widget build(BuildContext context) {
    final Random random = Random();
    return Container(
      margin: EdgeInsets.only(top:10,bottom:10),
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AspectRatio(
            aspectRatio: 1.0,
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(15),
              child: Image.network(
                leading[random.nextInt(leading.length)].imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width:30),
          Text(
            title,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 18,
            ),
          )
        ],
      ),
    );
  }
}