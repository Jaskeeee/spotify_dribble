import 'package:flutter/material.dart';
import 'package:spotify_dribble/core/components/widgets/hover_title.dart';
import 'package:spotify_dribble/core/player/presentation/components/widgets/repeat_button.dart';
import 'package:spotify_dribble/core/player/presentation/components/widgets/shuffle_button.dart';
import 'package:spotify_dribble/features/artist/domain/model/artist_simplified.dart';
import 'package:spotify_dribble/features/episode/domain/model/episode.dart';
import 'package:spotify_dribble/features/show/domain/model/show_simplified.dart';
import 'package:spotify_dribble/features/track/domain/model/track.dart';
import 'package:spotify_dribble/features/track/domain/model/track_album.dart';

class PlaybackDisplay extends StatefulWidget {
  final Episode? episode;
  final ShowSimplified? show;
  final Track? track;
  final TrackAlbum? album;
  final List<ArtistSimplified>? artists;
  final bool shuffleState;
  final String repeatState;
  final int duration;

  const PlaybackDisplay({
    super.key,
    this.track,
    this.album,
    this.artists,
    this.episode,
    this.show,
    required this.duration,
    required this.repeatState,
    required this.shuffleState,
  });

  @override
  State<PlaybackDisplay> createState() => _PlaybackDisplayState();
}

class _PlaybackDisplayState extends State<PlaybackDisplay> {
  @override
  Widget build(BuildContext context) {
    final Duration mediaDuration = Duration(milliseconds: widget.duration);
    return Container(
      height: 80,
      padding: EdgeInsets.fromLTRB(5, 1, 0, 1),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(10),
            child: Image.network(
              widget.album!=null? widget.album!.images[0].imageUrl: widget.show!.images[0].imageUrl,
              fit: BoxFit.fill,
              height: 70,
              width: 70,
            ),
          ),
          SizedBox(width: 20),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 400,
                child: HoverTitle(
                  title: widget.track != null
                      ? widget.track!.name
                      : widget.episode!.name,
                  fontSize: 18,
                  onTap: () => print("help i am being touched"),
                  color: Theme.of(context).colorScheme.primary,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              HoverTitle(
                title: widget.artists != null
                    ? widget.track!.artists[0].name
                    : widget.show!.name,
                fontSize: 16,
                onTap: () => print("help i am being touched"),
                color: Theme.of(context).colorScheme.secondary,
              ),
            ],
          ),
          Spacer(),
          Text(
            "${mediaDuration.inMinutes}:${(mediaDuration.inSeconds % 60).toString().padLeft(2, '0')}",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          SizedBox(width: 10),
          ShuffleButton(
            shuffleState: widget.shuffleState,
            size: 25,
          ),
          SizedBox(width: 10),
          RepeatButton(repeatState: widget.repeatState),
          SizedBox(width: 20),
        ],
      ),
    );
  }
}
