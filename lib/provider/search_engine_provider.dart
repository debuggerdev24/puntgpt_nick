import 'package:flutter/material.dart';
import 'package:puntgpt_nick/core/enum/app_enums.dart';
import 'package:puntgpt_nick/core/helper/log_helper.dart';
import 'package:puntgpt_nick/models/search_engine/runner_model.dart';
import 'package:puntgpt_nick/service/home/search_engine_api_service.dart';

class SearchEngineProvider extends ChangeNotifier {
  bool isSearched = false, _isMenuOpen = false;
  int _selectedTab = 0,
      _selectedRace = 0,
      _selectedDay = 0;
  JumpType _selectedRaceTimingEnum = JumpType.jumps_within_10mins;
  JumpType get selectedRaceTimingEnum => _selectedRaceTimingEnum;

  set selectedRaceTimingEnum(JumpType value) {
    _selectedRaceTimingEnum = value;
    notifyListeners();
  }
  
  int get selectedTab => _selectedTab;
  int get selectedRace => _selectedRace;
  int get selectedDay => _selectedDay;
  bool get isMenuOpen => _isMenuOpen;

  set setIsMenuOpen(bool value) {
    _isMenuOpen = value;
    notifyListeners();
  }

  set changeSelectedDay(int value) {
    _selectedDay = value;
    notifyListeners();
  }

  set changeSelectedRace(int value) {
    _selectedRace = value;
    notifyListeners();
  }

  set changeTab(int value) {
    _selectedTab = value;
    notifyListeners();
  }

 

  // List<String> raceStartingTimings = [
  //   "Jumps within 10mins",
  //   "Jumps within an hour",
  //   "Jumps today",
  //   "Jumps tomorrow",
  // ];

  /// Maps race starting timing indices to their corresponding JumpType enums
  List<JumpType> raceTimingEnums = [
    JumpType.jumps_within_10mins,
    JumpType.jumps_within_an_hour,
    JumpType.jumps_today,
    JumpType.jumps_tomorrow,
  ];

  String get selectedRaceTimingApiString => selectedRaceTimingEnum.name;

  // Track Section (Checkboxes)
  final List<Map<String, dynamic>> trackItems = [
    {"label": TrackType.placed_last_start.value, "checked": false, "apiValue": TrackType.placed_last_start.name},
    {"label": TrackType.placed_at_distance.value, "checked": false, "apiValue": TrackType.placed_at_distance.name},
    {"label": TrackType.placed_at_track.value, "checked": false, "apiValue": TrackType.placed_at_track.name},
    
  ];

  // Toggle method for track checkboxes
  void toggleTrackItem(String label, bool value) {
    final index = trackItems.indexWhere((item) => item["label"] == label);
    if (index != -1) {
      trackItems[index]["checked"] = value;
      notifyListeners();
    }
  }

  RunnerDataModel? runnerData;

  void setIsSearched({required bool value}) {
    isSearched = value;
    notifyListeners();
  }

  //* APIs functions
  Future<void> getSearchEngine({
    required Function(String error) onError,
    required VoidCallback onSuccess,
  }) async {
    runnerData = null;
    notifyListeners();
    // Get the first checked track item, if any
    final checkedTrackItem = trackItems.firstWhere(
      (item) => item["checked"] == true,
      orElse: () => <String, dynamic>{},
    );
    final trackValue = checkedTrackItem.isNotEmpty 
        ? checkedTrackItem["apiValue"] as String? 
        : null;

    final result = await SearchEngineAPISearvice.instance.getSearchEngine(
      jumpFilter: selectedRaceTimingApiString,
      track: trackValue,
    );
    result.fold(
      (l) {
        Logger.error(l.errorMsg);
        onError.call(l.errorMsg);
        runnerData = null;
      },
      (r) {
        Logger.info(r.toString());
        runnerData = (r["data"] != null) ? RunnerDataModel.fromJson(r["data"]) : null;
        onSuccess.call();
      },
    );
    notifyListeners();
  }

  Future<void> createSaveSearch({
    required Function(String error) onError,
    required VoidCallback onSuccess,
  }) async {
    final result = await SearchEngineAPISearvice.instance.createSaveSearch(
      data: {
        "name": "Short-distance Races",
        "filters": {"jump": "jumps_today", "track": "Flemington"},
        "comment": "Favorites for today",
      },
    );
    result.fold(
      (l) {
        onError.call("createSaveSearch function error: ${l.errorMsg}");
      },
      (r) {
        Logger.info(r.toString());
        onSuccess.call();
      },
    );
  }

  Future<void> getAllSaveSearch() async {
    // final result = await SearchEngineAPISearvice.instance.getAllSaveSearch();
    // result.fold((l) {
    //   Logger.error(l.errorMsg);
    // });
  }
}
