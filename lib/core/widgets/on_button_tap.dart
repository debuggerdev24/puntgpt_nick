import 'package:flutter/material.dart';

class OnButtonTap extends StatelessWidget {
  const OnButtonTap({super.key, required this.child,  this.onTap});

  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(onTap: onTap, child: child),
    );
  }
}
