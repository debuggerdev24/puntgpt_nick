import 'package:flutter/material.dart';
import 'package:puntgpt_nick/models/runner_model.dart';

class SearchEngineProvider extends ChangeNotifier {
  bool isSearched = false;
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

  /// Track Section (Checkboxes)
  final List<Map<String, dynamic>> trackItems = [
    {"label": "Placed last start", "checked": false},
    {"label": "Placed at distance", "checked": false},
    {"label": "Placed at track", "checked": false},
  ];

  /// Toggle method for track checkboxes
  void toggleTrackItem(String label, bool value) {
    final index = trackItems.indexWhere((item) => item["label"] == label);
    if (index != -1) {
      trackItems[index]["checked"] = value;
      notifyListeners();
    }
  }

  final List<RunnerModel> runnersList = [
    RunnerModel(
      label: "Delicacy",
      price: "8.50",
      date: "2025-09-28",
      numberOfRace: 7,
      nextRaceRemainTime: "14:35",
      number: 8,
    ),
    RunnerModel(
      label: "Smoking Joey",
      price: "14.50",
      date: "2025-09-28",
      numberOfRace: 7,
      nextRaceRemainTime: "14:35",
      number: 13,
    ),
  ];

  void setIsSearched({required bool value}) {
    isSearched = value;
    notifyListeners();
  }
}
