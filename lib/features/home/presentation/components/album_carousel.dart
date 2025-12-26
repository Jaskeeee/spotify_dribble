import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:spotify_dribble/core/constants/app_constants.dart';
import 'package:spotify_dribble/core/models/page_data.dart';
import 'package:spotify_dribble/features/album/domain/model/album.dart';
import 'package:spotify_dribble/features/album/presentation/cubit/album_cubit.dart';
import 'package:spotify_dribble/features/album/presentation/cubit/album_states.dart';

class AlbumCarousel extends StatefulWidget {
  const AlbumCarousel({super.key});

  @override
  State<AlbumCarousel> createState() => _AlbumCarouselState();
}

class _AlbumCarouselState extends State<AlbumCarousel> {
  @override
  void initState() {
    context.read<AlbumCubit>().getUserSavedAlbums(limit:40);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlbumCubit, AlbumStates>(
      builder: (context, state) {
        if (state is UserAlbumLoaded) {
          return Container(
            clipBehavior: Clip.none,
            height: 280,
            width: MediaQuery.of(context).size.width - 20,
            child: ShaderMask(
              blendMode: BlendMode.dstOut,
              shaderCallback: (bounds) => shader.createShader(bounds),
              child: CarouselSlider.builder(
                itemCount: state.albums.length,
                itemBuilder: (context, index, realIndex) {
                  final Album album= state.albums[index];
                  final PageData pageData= PageData(album:album);
                  return GestureDetector(
                    onTap:()=>Navigator.pushNamed(context,'/album',arguments:pageData),
                    child: Container(
                      margin: EdgeInsets.all(10),
                      width: 280,
                      height: 280,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.network(
                          album.images[0].imageUrl,
                        ),
                      ),
                    ),
                  );
                },
                options: CarouselOptions(
                  height: 280,
                  scrollPhysics:CarouselScrollPhysics(),
                  viewportFraction: 0.15,
                  scrollDirection: Axis.horizontal,
                  aspectRatio: 1.0,
                ),
              ),
            ),
          );
        } else if (state is AlbumError) {
          return Text(
            state.message,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 16,
            ),
          );
        }
        else{
          return LoadingAlbumCarousel();
        }
      },
    );
  }
}

class LoadingAlbumCarousel extends StatelessWidget {
  const LoadingAlbumCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      width: MediaQuery.of(context).size.width - 20,
      child: CarouselSlider.builder(
        itemCount: 10,
        itemBuilder: (context, index, realIndex) {
          return LoadingAlbumTile();
        },
        options: CarouselOptions(
          height: 280,
          viewportFraction: 0.15,
          scrollDirection: Axis.horizontal,
          aspectRatio: 1.0,
        ),
      ),
    );
  }
}

class LoadingAlbumTile extends StatelessWidget {
  const LoadingAlbumTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
      highlightColor: Colors.black.withValues(alpha: 0.3),
      child: Container(
        width: 280,
        height: 280,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
