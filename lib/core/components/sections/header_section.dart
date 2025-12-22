import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  final IconData iconData;
  final String title;
  const HeaderSection({
    super.key,
    required this.iconData,
    required this.title
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.fromLTRB(25,20,0,10),
      child: Row(
        children: [
          Icon(
            iconData,
            color: Theme.of(context).colorScheme.primary,
          ),
          SizedBox(width:10),
          Text(
            title,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
              fontSize:16
            ),
          )
        ],
      ),
    );
  }
}

