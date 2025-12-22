import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_dribble/core/models/image_model.dart';
import 'package:spotify_dribble/core/player/presentation/cubit/player_cubit.dart';

class TrackTile extends StatelessWidget {
  final String uri;
  final String title;
  final String subtitle;
  final ImageModel coverArt;
  final int duration;
  const TrackTile({
    super.key,
    required this.uri,
    required this.coverArt,
    required this.duration,
    required this.subtitle,
    required this.title
  });

  @override
  Widget build(BuildContext context) {
    final Duration mediaDuration = Duration(milliseconds:duration);
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: () =>context.read<PlayerCubit>().startPlayback(uris:[uri]),
      leading:ClipRRect(
        borderRadius: BorderRadiusGeometry.circular(15),
        child: SizedBox(
          child: Image.network(
            coverArt.imageUrl,
            filterQuality: FilterQuality.high,
            scale: 2.0,
            width:60,
            height:60,
          ),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
      titleAlignment: ListTileTitleAlignment.center,
      subtitle: Text(
        subtitle,
        style: TextStyle(fontSize: 14, color: Colors.grey),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "${mediaDuration.inMinutes}:${(mediaDuration.inSeconds % 60).toString().padLeft(2, '0')}",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          SizedBox(width:10),
          IconButton(
            onPressed:(){}, 
            icon: Icon(
              Icons.more_horiz_rounded,
              color: Theme.of(context).colorScheme.primary,
            )
          ),
          SizedBox(width:20),
        ],
      ),
    );
  }
}