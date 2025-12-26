import 'package:flutter/material.dart';
import 'package:spotify_dribble/core/auth/domain/model/spotify_user.dart';

class UserAvatar extends StatelessWidget {
  final SpotifyUser? user;
  const UserAvatar({
    super.key,
    required this.user
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(60),
      child: Image.network(
        user!.profileImage[0].imageUrl,
        width: 60,
        height: 60,
      ),
    );
  }
}