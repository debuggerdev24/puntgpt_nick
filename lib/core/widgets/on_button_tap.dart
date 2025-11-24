import 'package:flutter/material.dart';

class OnMouseTap extends StatelessWidget {
  const OnMouseTap({super.key, required this.child,  this.onTap});

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
