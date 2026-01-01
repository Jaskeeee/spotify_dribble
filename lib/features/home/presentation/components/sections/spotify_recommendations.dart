import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_dribble/core/components/sections/header_section.dart';
import 'package:spotify_dribble/core/components/widgets/loading_tile_widget.dart';
import 'package:spotify_dribble/core/components/widgets/media_tile.dart';
import 'package:spotify_dribble/features/category/domain/model/browse_category.dart';
import 'package:spotify_dribble/features/category/presentation/cubit/category_cubit.dart';
import 'package:spotify_dribble/features/category/presentation/cubit/category_states.dart';

class SpotifyRecommendations extends StatefulWidget {
  const SpotifyRecommendations({super.key});

  @override
  State<SpotifyRecommendations> createState() => _SpotifyRecommendationsState();
}

class _SpotifyRecommendationsState extends State<SpotifyRecommendations> {

  @override
  void initState() {
    context.read<CategoryCubit>().getSeveralBrowseCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeaderSection(
          iconData: Icons.library_music_rounded, 
          title: "Discover"
        ),
        SizedBox(height: 20,),
        Container(
          padding: EdgeInsets.symmetric(horizontal:25),
          height:300,
          width: 800,
          child: BlocBuilder<CategoryCubit,CategoryStates>(
            builder: (context,state){
              if(state is CategoriesLoaded){
                if(state.categories.isNotEmpty){
                  return GridView.builder(
                    itemCount: (state.categories.length+2),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 100
                    ), 
                    itemBuilder: (context,index){
                      if(index>=state.categories.length){
                        return Container(
                          height: 20,
                        );
                      }else{
                        final BrowseCategory category = state.categories[index];
                        return MediaTile(
                          leading: category.icons, 
                          title: category.name
                        );
                      }
                      
                    }
                  );
                }else{
                  return Center(
                    child: Text(
                      "No Recommendations Available at the moment"
                    ),
                  );
                }
              }
              else if(state is CategoryError){
                return Center(
                  child: Text(
                    state.message,
                  ),
                );
              }
              else{
                return GridView.builder(
                  itemCount: 8,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 100
                  ), 
                  itemBuilder: (context,index)=>LoadingTileWidget()
                );
              }
            }
          ),
        ),
      ],
    );
  }
}