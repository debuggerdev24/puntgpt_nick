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
  TextEditingController oddsRangeCtr = TextEditingController(),
      jockeyHorseWinsCtr = TextEditingController();
  List<SaveSearchModel>? saveSearches;
  List<String>? trackDetails,
      distanceDetails,
      searchFilterDetails,
      barrierList;
  SaveSearchModel? selectedSaveSearch;

  String? selectedTrack,
      selectedPlaceAtDistance,
      selectedWinsAtTrack,
      selectedWinsAtDistance,
      selectedPlaceAtTrack,
      selectedBarrier;

  set setSelectedTrack(String value) {
    selectedTrack = value;
    notifyListeners();
  }
  set setSelectedPlaceAtDistance(String value) {
    selectedPlaceAtDistance = value;
    notifyListeners();
  }
  set setSelectedWinsAtTrack(String value) {
    selectedWinsAtTrack = value;
    notifyListeners();
  }

  set setSelectedWinsAtDistance(String value) {
    selectedWinsAtDistance = value;
    notifyListeners();
  }
  set setSelectedPlaceAtTrack(String value) {
    selectedPlaceAtTrack = value;
    notifyListeners();
  }
  set setSelectedBarrier(String value) {
    selectedBarrier = value;
    notifyListeners();
  }

  set setSelectedRaceTimingEnum(JumpType value) {
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

  // Maps race starting timing indices to their corresponding JumpType enums
  List<JumpType> raceTimingEnums = [
    JumpType.jumps_within_10mins,
    JumpType.jumps_within_an_hour,
    JumpType.jumps_today,
    JumpType.jumps_tomorrow,
  ];

  String get selectedRaceTimingApiString => selectedRaceTimingEnum.name;

  //* Home Screen Track Section (Checkboxes)
  final List<TrackItemModel> trackBoolItems = [
    TrackItemModel.fromTrackType(TrackType.placed_last_start),
    TrackItemModel.fromTrackType(TrackType.won_last_start),
    TrackItemModel.fromTrackType(TrackType.won_last_12_months),
    // TrackItemModel.fromTrackType(TrackType.odds_range),
  ];

  //* Saved Search Screen Track Section (Checkboxes)
  final List<TrackItemModel> savedSearchTrackItems = [
    TrackItemModel.fromTrackType(TrackType.placed_last_start),
    TrackItemModel.fromTrackType(TrackType.won_last_start),
    TrackItemModel.fromTrackType(TrackType.won_last_12_months),
    // TrackItemModel.fromTrackType(TrackType.odds_range),
  ];

  //* Toggle method for track checkboxes
  void toggleTrackItem(String label, bool value) {
    final index = trackBoolItems.indexWhere(
      (item) => item.trackType.value == label,
    );
    if (index != -1) {
      trackBoolItems[index] = trackBoolItems[index].copyWith(checked: value);
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

  //todo APIs functions

  Future<void> getTrackDetails() async {
    trackDetails = null;
    notifyListeners();
    final result = await SearchEngineAPISearvice.instance.getTrackDetails();

    result.fold(
      (l) {
        Logger.error(l.errorMsg);
      },
      (r) {
        final data = r["data"];
        if (data is List) {
          trackDetails = data.map((e) => e.toString()).toList();
        } else {
          trackDetails = null;
        }
      },
    );
    notifyListeners();
  }

  Future<void> getDistanceDetails() async {
    distanceDetails = null;
    notifyListeners();
    final result = await SearchEngineAPISearvice.instance.getDistanceDetails();
    result.fold(
      (l) {
        Logger.error(l.errorMsg);
      },
      (r) {
        final data = r["data"];
        if (data is List) {
          distanceDetails = data.map((e) => e.toString()).toList();
        } else {
          distanceDetails = null;
        }
      },
    );
    notifyListeners();
  }

  Future<void> getBarrierDetails() async {
    barrierList = null;
    notifyListeners();
    final result = await SearchEngineAPISearvice.instance.getBarrierDetails();
    result.fold(
      (l) {
        Logger.error(l.errorMsg);
      },
      (r) {
        final data = r["data"];
        if (data is List) {
          barrierList = data.map((e) => e.toString()).toList();
        } else {
          barrierList = null;
        }
      },
    );
    notifyListeners();
  }

  Future<void> getSearchEngine({
    required Function(String error) onError,
    required VoidCallback onSuccess,
  }) async {
    runnerData = null;
    notifyListeners();
    // Get the first checked track item, if any
    final checkedTrackItem = trackBoolItems
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
          "placed_last_start": trackBoolItems[0].checked,
          "placed_at_distance": selectedPlaceAtDistance,
          "placed_at_track": selectedPlaceAtTrack,
          "odds_range": oddsRangeCtr.text,
          "wins_at_track": selectedWinsAtTrack,
          "win_at_distance": selectedWinsAtDistance,
          "won_last_start": trackBoolItems[1].checked,
          "won_last_12_months": trackBoolItems[2].checked,
          "jockey_horse_wins": jockeyHorseWinsCtr.text,
          "barrier": selectedBarrier,
          "jockey_strike_rate_last_12_months": "",
          
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
