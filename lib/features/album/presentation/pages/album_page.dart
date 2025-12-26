import 'package:flutter/material.dart';
import 'package:spotify_dribble/core/auth/presentation/components/user_avatar.dart';
import 'package:spotify_dribble/core/models/page_data.dart';
import 'package:spotify_dribble/features/album/domain/model/album.dart';
import 'package:spotify_dribble/features/album/presentation/pages/album_play_button.dart';
import 'package:spotify_dribble/features/album/presentation/pages/album_tracks.dart';
import 'package:spotify_dribble/features/artist/data/spotify_artist_repo.dart';
import 'package:spotify_dribble/features/artist/presentation/components/artist_avatar.dart';

class AlbumPage extends StatefulWidget {
  final PageData pageData;
  const AlbumPage({super.key, required this.pageData});

  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage>with RouteAware {
  final SpotifyArtistRepo spotifyArtistRepo = SpotifyArtistRepo();
  @override
  Widget build(BuildContext context) {
    final Album album = widget.pageData.album!;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              margin:EdgeInsets.zero,
              padding: EdgeInsets.only(left:30,top:10),
              child: IconButton(
                onPressed: ()=>Navigator.of(context).pop(), 
                icon: Icon(
                  Icons.arrow_back
                )
              ),
            ),
          ],
        ),
        Container(
          height: 350,
          padding: EdgeInsets.all(30),
          child: Row(
            children: [
              SizedBox(
                height: 300,
                width: 300,
                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(40),
                  child: Image.network(
                    album.images[0].imageUrl,
                  ),
                ),
              ),
              SizedBox(
                width:40,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      album.name,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 50,
                        overflow: TextOverflow.ellipsis
                      ),
                      maxLines:2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20
                    ),
                    child:ArtistAvatar(artistId:album.artists[0].id)
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  AlbumPlayButton()
                ],
              )
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.zero,
            margin: EdgeInsets.zero,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
              color: Colors.black.withValues(alpha: 0.3),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal:30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                 AlbumTracks(album: album)
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
