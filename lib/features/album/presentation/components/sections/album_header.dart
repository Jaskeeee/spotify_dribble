import 'package:flutter/material.dart';

class AlbumHeader extends StatelessWidget {
  const AlbumHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:30,top:20),
      child: Row(
        children:[
          IconButton(
            onPressed: ()=>Navigator.of(context).pop(), 
            icon: Icon(
              Icons.arrow_back,
              size: 30,
            )
          ),
        ],
      ),
    );
  }
}