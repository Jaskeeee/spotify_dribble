import 'package:flutter/material.dart';
import 'package:spotify_dribble/core/auth/domain/model/spotify_user.dart';
import 'package:spotify_dribble/core/auth/presentation/components/user_avatar.dart';

class BrowsingHeader extends StatelessWidget {
  final SpotifyUser? user;
  const BrowsingHeader({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
          SizedBox(
            height: 60,
            width: 400,
            child: TextField(
              style: TextStyle(color: Colors.white),
              cursorColor: Colors.white,
              decoration: InputDecoration(
                alignLabelWithHint: true,
                filled: true,
                fillColor: Colors.grey.shade900.withValues(alpha:0.6),
                hintText: "Search by Title, Artist or Album...",
                hintStyle: TextStyle(color:Theme.of(context).colorScheme.secondary),
                prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(12),
                enabled: true,
                enabledBorder:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(60),
                  borderSide: BorderSide.none
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(60),
                  borderSide: BorderSide.none
                ) 
              ),
            ),
          ),
        Spacer(),
        UserAvatar(user: user),
      ],
    );
  }
}
