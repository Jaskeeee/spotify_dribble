import 'package:flutter/material.dart';

class CommonIconButton extends StatelessWidget {
  final IconData iconData;
  final void Function() onPressed;
  const CommonIconButton({
    super.key,
    required this.iconData,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        iconData,
        color: Theme.of(context).colorScheme.primary,
        size: 35,
      ),
    );
  }
}
