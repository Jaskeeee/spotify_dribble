import 'package:flutter/material.dart';
import 'package:spotify_dribble/core/models/image_model.dart';

class PlaybackDisplayTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final ImageModel coverArt;
  final int duration;
  final Widget? trailingWidget;
  const PlaybackDisplayTile({
    super.key,
    required this.title,
    required this.coverArt,
    required this.duration,
    required this.subtitle,
    required this.trailingWidget
  });

  @override
  Widget build(BuildContext context) {
    final Duration mediaDuration = Duration(milliseconds:duration);
    return ListTile(
      minVerticalPadding: 0,
      leadingAndTrailingTextStyle: TextStyle(),
      contentPadding: EdgeInsets.zero,
      leading: ClipRRect(
        borderRadius: BorderRadiusGeometry.circular(15),
        child: SizedBox(
          child: Image.network(
            coverArt.imageUrl,
            // fit: BoxFit.fill,
            gaplessPlayback: true,
            height: 60,
            width: 60,
            filterQuality: FilterQuality.high,
            cacheHeight: coverArt.height,
            cacheWidth: coverArt.width,
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
        mainAxisAlignment: MainAxisAlignment.center,
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
