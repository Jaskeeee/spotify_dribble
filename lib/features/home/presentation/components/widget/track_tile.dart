import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_dribble/core/components/widgets/hover_title.dart';
import 'package:spotify_dribble/core/models/image_model.dart';
import 'package:spotify_dribble/core/player/presentation/cubit/player_cubit.dart';
import 'package:spotify_dribble/features/artist/domain/model/artist_simplified.dart';

class TrackTile extends StatelessWidget {
  final String uri;
  final String title;
  final List<ArtistSimplified> artists;
  final ImageModel coverArt;
  final int duration;
  const TrackTile({
    super.key,
    required this.uri,
    required this.coverArt,
    required this.duration,
    required this.artists,
    required this.title
  });

  @override
  Widget build(BuildContext context) {
    final List<String> artistsNames = List.generate(
      artists.length, (index)=>artists[index].name
    ); 
    final Duration mediaDuration = Duration(milliseconds:duration);
    return GestureDetector(
      onTap: ()=>context.read<PlayerCubit>().startPlayback(uris:[uri]),
      child: Container(
        margin: EdgeInsets.only(left:0,top:5,bottom:5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(10),
              child: Image.network(
                coverArt.imageUrl,
                height:62,
                width:62,
              ),
            ),
            SizedBox(
              width:20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HoverTitle(
                  title: title, 
                  fontSize: 16, 
                  onTap: ()=>print("instead of fucking clicking on it try implementing it"), 
                  color: Theme.of(context).colorScheme.primary
                ),
                Text(
                  artistsNames.join(', '),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 14
                  ),
                ),
              ],
            ),
            Spacer(),
            Text(
              "${mediaDuration.inMinutes}:${(mediaDuration.inSeconds%60).toString().padLeft(2,'0')}",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w500,
                fontSize: 16
              ),
            ),
            SizedBox(width:10),
            IconButton(
              onPressed:(){
                print("object");
              }, 
              icon: Icon(
                Icons.more_horiz_outlined,
                color:Theme.of(context).colorScheme.primary,
              )
            ),
            SizedBox(
              width: 20,
            )
          ],
        ),
      ),
    );
  }
}