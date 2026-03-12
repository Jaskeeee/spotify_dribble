import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_dribble/core/models/page_data.dart';
import 'package:spotify_dribble/features/artist/domain/model/artist.dart';
import 'package:spotify_dribble/features/artist/presentation/cubit/artist_cubit.dart';
import 'package:spotify_dribble/features/artist/presentation/cubit/artist_states.dart';

class ArtistPage extends StatefulWidget {
  final PageData pageData;
  const ArtistPage({
    super.key,
    required this.pageData
  });

  @override
  State<ArtistPage> createState() => _ArtistPageState();
}

class _ArtistPageState extends State<ArtistPage> {
  late String id;
  @override
  void initState() {
    id=widget.pageData.artist?.id ?? widget.pageData.artistSimplified!.id; 
    context.read<ArtistCubit>().getArtist(id:id);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArtistCubit,ArtistStates>(
      builder:(context,state){
        if(state is ArtistLoaded){
          final Artist artist = state.artist;
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(0), 
                  child:  Row(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        margin: EdgeInsets.zero,
                        padding: EdgeInsets.zero,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              spreadRadius:3,
                              blurRadius: 5,
                              blurStyle: BlurStyle.normal,
                              color: Colors.grey.shade800.withValues(alpha:0.5),
                            )
                          ]
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                            artist.images[0].imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        width:20,
                      ),
                      Expanded(
                        child: Text(
                          artist.name,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                ),
                stretch: true,
                floating: true,
                expandedHeight: 500,
                flexibleSpace: FlexibleSpaceBar(
                  expandedTitleScale: 2,
                  background: Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50)
                      ),
                      color: Colors.transparent,
                      image: DecorationImage(
                        image:NetworkImage(artist.images[0].imageUrl),
                        fit: BoxFit.cover,
                        alignment: Alignment(0.0,-0.7)
                      )
                    ),
                    child: ClipRRect(
                      clipBehavior: Clip.hardEdge,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50)
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 10,sigmaY: 10
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.only(
                              topLeft:Radius.circular(50),
                              topRight: Radius.circular(50)
                            )
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        }
        else if(state is ArtistError){
          return Center(
            child: Text(state.message),
          );
        }
        else{
          return Center(child: CircularProgressIndicator());
        }
      }
    );
  }
}