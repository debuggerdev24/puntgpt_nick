import 'package:flutter/material.dart';

class SearchEngineProvider extends ChangeNotifier {
  int _selectedRaceTimingIndex = 0;
  int get selectedRaceTimingIndex => _selectedRaceTimingIndex;
  set selectedRaceTimingIndex(int value) {
    _selectedRaceTimingIndex = value;
    notifyListeners();
  }

  List<String> raceStartingTimings = [
    "Jumps within 10mins",
    "Jumps within an hour",
    "Jumps today",
    "Jumps tomorrow",
  ];

  final List<Map<String, dynamic>> puntGptFilters = [
    {
      "label": "Distance Wins",
      "type": "number",
      "options": [0, 1, 2, 3, 4, 5],
    },
    {
      "label": "Distance Places",
      "type": "dropdown",
      "options": ["Any", "1+", "2+", "3+", "4+", "5+"],
    },
    {
      "label": "Track Wins",
      "type": "number",
      "options": [0, 1, 2, 3, 4],
    },
    {
      "label": "Track Places",
      "type": "dropdown",
      "options": ["Any", "1+", "2+", "3+", "4+"],
    },
    {
      "label": "Odds",
      "type": "dropdown",
      "options": ["Any", "< 2.0", "2.0 - 4.0", "4.0 - 8.0", "8.0+"],
    },
    {
      "label": "Race Favourite Odds",
      "type": "dropdown",
      "options": ["Favourite", "Top 3", "Top 5", "Longshot"],
    },
    {
      "label": "Win %",
      "type": "number",
      "options": [10, 20, 30, 40, 50, 60, 70],
    },
    {
      "label": "Place %",
      "type": "number",
      "options": [10, 20, 30, 40, 50, 60, 70],
    },
  ];
}
