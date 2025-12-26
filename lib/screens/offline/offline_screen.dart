import 'package:flutter/material.dart';
import 'package:puntgpt_nick/screens/offline/widget/offline_view.dart';

class OfflineScreen extends StatelessWidget {
  const OfflineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: offlineView());
  }
}
