import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_dribble/core/models/page_data.dart';
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
    context.read<ArtistCubit>().getArtistAlbums(id:id);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArtistCubit,ArtistStates>(
      builder:(context,state){
        if(state is ArtistAlbumLoaded){
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 400,
                flexibleSpace: FlexibleSpaceBar(
                  expandedTitleScale: 400,
                  background: widget.pageData.artist!=null ?Image.network(widget.pageData.artist!.images[0].imageUrl,fit: BoxFit.cover,alignment: Alignment.topCenter,):Container(
                    color: Colors.green,
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