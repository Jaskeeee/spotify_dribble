import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:spotify_dribble/features/album/presentation/cubit/album_cubit.dart';
import 'package:spotify_dribble/features/album/presentation/cubit/album_states.dart';

class AlbumCarousel extends StatefulWidget {
  const AlbumCarousel({
    super.key,
  });

  @override
  State<AlbumCarousel> createState() => _AlbumCarouselState();
}

class _AlbumCarouselState extends State<AlbumCarousel> {
  @override
  void initState() {
    context.read<AlbumCubit>().getUserSavedAlbums();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlbumCubit,AlbumStates>(
      builder: (context,state){
        if(state is UserAlbumLoaded){
        return ShaderMask(
            blendMode: BlendMode.dstOut,
            shaderCallback: (bounds) {
              return LinearGradient(
                begin:Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: [
                  0.0,
                  0.1,
                  0.8,
                  0.9
                ],
                colors: [
                  Colors.white,
                  Colors.transparent,
                  Colors.transparent,
                  Colors.white
                ]
              ).createShader(bounds);
            },
            child: CarouselSlider.builder(
              itemCount: state.albums.length, 
              options: CarouselOptions(
                viewportFraction: 0.13,
                scrollDirection: Axis.horizontal,
                aspectRatio: 1.0,
                height: 300
              ), 
              itemBuilder: (BuildContext context, int index, int realIndex) {  
                final String albumArtUrl = state.albums[index].images[0].imageUrl;
                return ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(      
                    albumArtUrl,
                    height:220,
                    width: 220,
                  ),
                );
              },
            ),
          );
        }
        else if(state is AlbumError){
          return Center(
            child: Text(
              state.message,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary
              ),
            ),
          );
        }
        else{
          return Center(
            child: LoadingAnimationWidget.waveDots(
              color: Theme.of(context).colorScheme.primary, 
              size: 50
            ),
          );
        }
      }
    );
  }
}