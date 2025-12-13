import 'package:flutter/material.dart';
import 'package:puntgpt_nick/screens/home/web/home_screen_web.dart';

class BookiesScreenWeb extends StatelessWidget {
  const BookiesScreenWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(child: Text("Bookies Screen")),
        Align(
          alignment: AlignmentGeometry.bottomRight,
          child: askPuntGPTButtonWeb(context: context),
        ),
      ],
    );
  }
}
