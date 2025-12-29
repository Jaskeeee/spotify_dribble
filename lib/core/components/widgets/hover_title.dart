import 'package:flutter/material.dart';

class HoverTitle extends StatefulWidget {
  final String title;
  final Color color;
  final double fontSize;
  final void Function() onTap;
  final TextOverflow? overflow;
  final FontWeight? weight;
  const HoverTitle({
    super.key, 
    required this.title,
    required this.fontSize,
    required this.onTap,
    required this.color,
    this.weight,
    this.overflow,
  });

  @override
  State<HoverTitle> createState() => _TrackTitleState();
}

class _TrackTitleState extends State<HoverTitle> {
  bool hover = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event)=>setState(() {
        hover=true;
      }),
      onExit: (event)=>setState(() {
        hover=false;
      }),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Text(
          widget.title,
          style: TextStyle(
            color: widget.color,
            fontWeight: widget.weight,
            fontSize: widget.fontSize,
            decorationColor: widget.color,
            decorationThickness: 1,
            decorationStyle: TextDecorationStyle.solid,
            decoration:hover
            ?TextDecoration.underline 
            :TextDecoration.none
          ),
          overflow:widget.overflow,
        ),
      ),
    );
  }
}
