import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingTileWidget extends StatefulWidget {
  const LoadingTileWidget({super.key});

  @override
  State<LoadingTileWidget> createState() => _LoadingTileWidgetState();
}

class _LoadingTileWidgetState extends State<LoadingTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor:Colors.black.withValues(alpha:0.3),
      highlightColor:Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
      child: ListTile(
        contentPadding: EdgeInsets.all(10),
        leading: AspectRatio(
          aspectRatio: 1.0,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(15)
            ),
            width: 100,
            height: 100,
          ),
        ),
        title: ShimmerWidget.rectangular(height:15),
        subtitle:ShimmerWidget.rectangular(height:10),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ShimmerWidget.cicrular(height:30, width:30),
            SizedBox(width: 20,),
            ShimmerWidget.cicrular(height:30, width:30),
          ],
        ),
      )
    );
  }
}

class ShimmerWidget extends StatelessWidget {
  final double height;
  final double width;
  final ShapeBorder shapeBorder;

  ShimmerWidget.cicrular({
    super.key,
    required this.height,
    required this.width
  }):shapeBorder=CircleBorder();

  ShimmerWidget.rectangular({
    super.key,
    required this.height,
    this.width= double.infinity
  }):shapeBorder= RoundedRectangleBorder(
    borderRadius: BorderRadiusGeometry.circular(20)
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: Colors.black.withValues(alpha:0.5),
        shape: shapeBorder
      ),
      height: height,
      width: width,
    );
  }
}
