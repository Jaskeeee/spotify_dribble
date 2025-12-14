import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:spotify_dribble/core/components/widgets/window_buttons.dart';

class WindowTitleBar extends StatelessWidget {
  final Widget child;
  const WindowTitleBar({
    super.key,
    required this.child
  });

  @override
  Widget build(BuildContext context) {
    return WindowTitleBarBox(
      child: Row(
        children: [
          Expanded(
            child: MoveWindow(
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal:15),
                child: child,
              ),
            )
          ),
          const WindowButtons(),
        ],
      ),
    );
  }
}