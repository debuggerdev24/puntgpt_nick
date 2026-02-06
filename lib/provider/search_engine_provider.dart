import 'package:flutter/material.dart';
import 'package:puntgpt_nick/core/enum/app_enums.dart';
import 'package:puntgpt_nick/core/helper/log_helper.dart';
import 'package:puntgpt_nick/models/search_engine/runner_model.dart';
import 'package:puntgpt_nick/models/search_engine/search_model.dart';
import 'package:puntgpt_nick/models/search_engine/track_item_model.dart';
import 'package:puntgpt_nick/service/home/search_engine_api_service.dart';

class SearchEngineProvider extends ChangeNotifier {
  bool isSearched = false, _isMenuOpen = false, _isEditSavedSearch = false;
  int _selectedTab = 0, _selectedRace = 0, _selectedDay = 0;
  JumpType _selectedRaceTimingEnum = JumpType.jumps_within_10mins;
  JumpType get selectedRaceTimingEnum => _selectedRaceTimingEnum;
  List<SaveSearchModel>? saveSearches;
  SaveSearchModel? selectedSaveSearch;
  set selectedRaceTimingEnum(JumpType value) {
    _selectedRaceTimingEnum = value;
    notifyListeners();
  }

  int get selectedTab => _selectedTab;
  int get selectedRace => _selectedRace;
  int get selectedDay => _selectedDay;
  bool get isMenuOpen => _isMenuOpen;
  bool get isEditSavedSearch => _isEditSavedSearch;
  set setIsEditSavedSearch(bool value) {
    _isEditSavedSearch = value;
    notifyListeners();
  }

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

  /// Maps race starting timing indices to their corresponding JumpType enums
  List<JumpType> raceTimingEnums = [
    JumpType.jumps_within_10mins,
    JumpType.jumps_within_an_hour,
    JumpType.jumps_today,
    JumpType.jumps_tomorrow,
  ];

  String get selectedRaceTimingApiString => selectedRaceTimingEnum.name;

  //* Home Screen Track Section (Checkboxes)
  final List<TrackItemModel> trackItems = [
    TrackItemModel.fromTrackType(TrackType.placed_last_start),
    TrackItemModel.fromTrackType(TrackType.placed_at_distance),
    TrackItemModel.fromTrackType(TrackType.placed_at_track),
    TrackItemModel.fromTrackType(TrackType.odds_range),
  ];

  //* Saved Search Screen Track Section (Checkboxes)
  final List<TrackItemModel> savedSearchTrackItems = [
    TrackItemModel.fromTrackType(TrackType.placed_last_start),
    TrackItemModel.fromTrackType(TrackType.placed_at_distance),
    TrackItemModel.fromTrackType(TrackType.placed_at_track),
    TrackItemModel.fromTrackType(TrackType.odds_range),
  ];

  //* Toggle method for track checkboxes
  void toggleTrackItem(String label, bool value) {
    final index = trackItems.indexWhere(
      (item) => item.trackType.value == label,
    );
    if (index != -1) {
      trackItems[index] = trackItems[index].copyWith(checked: value);
      notifyListeners();
    }
  }

  //* Toggle method for saved search track checkboxes
  void updateSavedSearchTrackItem(String label, bool value) {
    final index = savedSearchTrackItems.indexWhere(
      (item) => item.trackType.value == label,
    );
    if (index != -1) {
      savedSearchTrackItems[index] = savedSearchTrackItems[index].copyWith(
        checked: value,
      );
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
    final checkedTrackItem = trackItems
        .where((item) => item.checked == true)
        .firstOrNull;
    final trackValue = checkedTrackItem?.trackType.name;

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
        runnerData = (r["data"] != null)
            ? RunnerDataModel.fromJson(r["data"])
            : null;
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
        "name": "Custom Name",
        "filters": {
          "track": "Flemington",
          trackItems[0].trackType.name: trackItems[0].checked,
          trackItems[1].trackType.name: trackItems[1].checked,
          trackItems[2].trackType.name: trackItems[2].checked,
        },
        "comment": "Custom comment",
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
    saveSearches = null;
    notifyListeners();
    final result = await SearchEngineAPISearvice.instance.getAllSaveSearch();
    result.fold(
      (l) {
        Logger.error(l.errorMsg);
        saveSearches = [];
      },
      (r) {
        saveSearches = (r["data"] != null)
            ? (r["data"] as List)
                  .map((e) => SaveSearchModel.fromJson(e))
                  .toList()
            : null;
        notifyListeners();
      },
    );
    notifyListeners();
  }

  Future<void> getSaveSearchDetails({required String id}) async {
    selectedSaveSearch = null;
    notifyListeners();
    final result = await SearchEngineAPISearvice.instance.getSaveSearchDetails(
      id: id,
    );
    result.fold(
      (l) {
        Logger.error(l.errorMsg);
      },
      (r) {
        selectedSaveSearch = SaveSearchModel.fromJson(r["data"]);
        savedSearchTrackItems[0] =
            TrackItemModel.fromTrackType(TrackType.placed_last_start).copyWith(
              checked: selectedSaveSearch?.filters.placedLastStart ?? false,
            );
        savedSearchTrackItems[1] =
            TrackItemModel.fromTrackType(TrackType.placed_at_distance).copyWith(
              checked: selectedSaveSearch?.filters.placedAtDistance ?? false,
            );
        savedSearchTrackItems[2] = TrackItemModel.fromTrackType(
          TrackType.placed_at_track,
        ).copyWith(checked: selectedSaveSearch?.filters.placedAtTrack ?? false);
      },
    );
    notifyListeners();
  }

  Future<void> editSaveSearch({required VoidCallback onSuccess}) async {
    final id = selectedSaveSearch!.id.toString();
    final result = await SearchEngineAPISearvice.instance.editSaveSearch(
      id: id,
      data: {
        "name":
            selectedSaveSearch?.name ??
            "Custom edited Name", //"Custom edited Name",
        "filters": {
          "track": selectedSaveSearch?.filters.track ?? "Flemington",
          savedSearchTrackItems[0].trackType.name:
              savedSearchTrackItems[0].checked,
          savedSearchTrackItems[1].trackType.name:
              savedSearchTrackItems[1].checked,
          savedSearchTrackItems[2].trackType.name:
              savedSearchTrackItems[2].checked,
        },
        "comment":
            selectedSaveSearch?.comment ??
            "Custom edited comment", //"Custom edited comment",
      },
    );
    result.fold(
      (l) {
        Logger.error(l.errorMsg);
      },
      (r) {
        setIsEditSavedSearch = false;
        getSaveSearchDetails(id: id);
        onSuccess.call();
      },
    );
    notifyListeners();
  }

  Future<void> deleteSaveSearch({
    required String id,
    required VoidCallback onSuccess,
  }) async {
    final result = await SearchEngineAPISearvice.instance.deleteSaveSearch(
      id: id,
    );
    result.fold(
      (l) {
        Logger.error(l.errorMsg);
      },
      (r) {
        onSuccess.call();
      },
    );
  }
}
