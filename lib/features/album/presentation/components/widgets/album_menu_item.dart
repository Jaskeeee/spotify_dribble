import 'package:flutter/material.dart';

class AlbumMenuItem extends StatelessWidget {
  final String title;
  final IconData iconsData;
  final void Function() onTap;
  const AlbumMenuItem({
    super.key,
    required this.iconsData,
    required this.title,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(top:5,bottom: 5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(iconsData),
            SizedBox(width: 5),
            Text(
              title,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
