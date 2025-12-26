import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_dribble/features/artist/domain/model/artist.dart';
import 'package:spotify_dribble/features/artist/presentation/cubit/artist_cubit.dart';
import 'package:spotify_dribble/features/artist/presentation/cubit/artist_states.dart';

class ArtistAvatar extends StatefulWidget {
  final String artistId;
  const ArtistAvatar({super.key, required this.artistId});

  @override
  State<ArtistAvatar> createState() => _ArtistAvatarState();
}

class _ArtistAvatarState extends State<ArtistAvatar> {
  @override
  void initState() {
    context.read<ArtistCubit>().getArtist(id: widget.artistId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArtistCubit, ArtistStates>(
      builder: (context, state) {
        if (state is ArtistLoaded) {
          final Artist artist = state.artist;
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                foregroundImage: NetworkImage(
                  artist.images[0].imageUrl,
                )
              ),
              SizedBox(width:10),
              Text(
                artist.name,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 16
                ),
              )
            ],
          );
        }
        return Icon(Icons.account_circle_outlined, size: 50);
      },
    );
  }
}
