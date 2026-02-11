import 'package:flutter/foundation.dart';

class ClassicFormGuideProvider extends ChangeNotifier {
  List<String> _classicFormGuide = [];

  List<String> get classicFormGuide => _classicFormGuide;

  void addClassicFormGuide(String classicFormGuide) {
    _classicFormGuide.add(classicFormGuide);
    // notifyListeners();
  }
}