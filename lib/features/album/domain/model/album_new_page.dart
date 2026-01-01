import 'package:flutter/material.dart';

class AlbumNewPage extends StatefulWidget {
  const AlbumNewPage({super.key});

  @override
  State<AlbumNewPage> createState() => _AlbumNewPageState();
}

class _AlbumNewPageState extends State<AlbumNewPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 1,
          child: Container()
        ),
        Flexible(
          flex: 1,
          child: Container(
            color: Colors.black.withValues(alpha:0.3),
          )
        )
      ],
    );
  }
}