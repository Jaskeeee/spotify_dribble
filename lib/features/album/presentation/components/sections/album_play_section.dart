import 'package:flutter/material.dart';
import 'package:flutter_popup/flutter_popup.dart';
import 'package:spotify_dribble/core/constants/app_constants.dart';
import 'package:spotify_dribble/features/album/presentation/components/widgets/album_menu_item.dart';
import 'package:spotify_dribble/features/album/presentation/components/widgets/album_play_button.dart';
import 'package:spotify_dribble/features/album/presentation/components/widgets/album_shuffle_button.dart';

class AlbumPlaySection extends StatefulWidget {
  final List<String> ids;
  const AlbumPlaySection({super.key, required this.ids});

  @override
  State<AlbumPlaySection> createState() => _AlbumPlaySectionState();
}

class _AlbumPlaySectionState extends State<AlbumPlaySection> {
  bool shuffleState = false;
  @override
  Widget build(BuildContext context) {
    List<String> trackIds = widget.ids;
    return Row(
      children: [
        AlbumPlayButton(ids: trackIds, shuffleState: shuffleState),
        SizedBox(width: 20),
        AlbumShuffleButton(
          shuffleState: shuffleState,
          onPressed: () {
            List<String> shuffledIds = widget.ids;
            setState(() {
              shuffleState = !shuffleState;
            });
            shuffledIds.shuffle();
            trackIds = shuffledIds;
          },
        ),
        SizedBox(width: 20),
        CustomPopup(
          barrierColor: Colors.transparent,
          backgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha:0.3),
          arrowColor: Theme.of(context).colorScheme.primary.withValues(alpha:0.3),
          position: PopupPosition.auto,
          showArrow: true,
          rootNavigator: true,
          contentPadding: EdgeInsets.fromLTRB(15,20,15,20),
          animationDuration: Duration(milliseconds:300),
          animationCurve: Curves.easeIn,
          content: SizedBox(
            width: 200,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: albumMenuItems.length,
              itemBuilder: (context, index) {
                return AlbumMenuItem(
                  iconsData: albumMenuItems[index], 
                  title: albumMenuItemsTitle[index],
                  onTap: ()=>print("this works"),
                );
              },
            ),
          ),
          child: Icon(
            Icons.more_horiz_outlined,
            size: 60,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ],
    );
  }
}
