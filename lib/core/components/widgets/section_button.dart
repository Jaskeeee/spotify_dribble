import 'package:flutter/material.dart';

class SectionButton extends StatefulWidget {
  final IconData iconData;
  final String title;
  final void Function() onTap;
  final String buttonRouteName;
  final String routeName;
  const SectionButton({
    super.key,
    required this.iconData,
    required this.title,
    required this.onTap,
    required this.buttonRouteName,
    required this.routeName
  });

  @override
  State<SectionButton> createState() => _SectionButtonState();
}

class _SectionButtonState extends State<SectionButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:widget.onTap,
      child: Container(
        margin:EdgeInsets.zero,
        padding: EdgeInsets.fromLTRB(20,10,20,10),
        decoration: BoxDecoration(
          color: widget.buttonRouteName==widget.routeName
          ?Colors.black.withValues(alpha: 0.3)
          :Colors.transparent,
          borderRadius: BorderRadius.circular(30)
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              widget.iconData,
              color: Theme.of(context).colorScheme.primary,
            ),
            SizedBox(width:10),
            Text(
            widget.title,
            style: TextStyle(
              color:Theme.of(context).colorScheme.primary,
              fontSize: 16,
              fontWeight: FontWeight.w500
            ),
            )
          ],
        ),
      ),
    );
  }
}