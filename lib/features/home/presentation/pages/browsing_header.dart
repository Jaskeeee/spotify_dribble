import 'package:flutter/material.dart';
import 'package:spotify_dribble/core/auth/domain/model/spotify_user.dart';
import 'package:spotify_dribble/core/auth/presentation/components/user_avatar.dart';
import 'package:spotify_dribble/features/search/data/spotify_search_repo.dart';

class BrowsingHeader extends StatelessWidget {
  final SpotifyUser? user;
  const BrowsingHeader({
    super.key,
    required this.user
  });

  @override
  Widget build(BuildContext context) {
    final SpotifySearchRepo spotifySearchRepo = SpotifySearchRepo();
    return Row(
      children: [
        // GestureDetector(
        //   onTap: ()async{
        //     await spotifySearchRepo.search(q:"bring me the horizon");
        //   },
        //   child: Container(
        //     width: 600,
        //     height: 60,
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(50),
        //       color: Colors.green,
        //     ),
        //   ),
        // ),
        SizedBox(child: SearchBar()),
        Spacer(),
        UserAvatar(user: user)
      ],
    );
  }
}
