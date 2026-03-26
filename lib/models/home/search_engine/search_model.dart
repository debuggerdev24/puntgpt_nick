class SaveSearchModel {

  SaveSearchModel({
    required this.id,
    required this.name,
    required this.filters,
    required this.comment,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SaveSearchModel.fromJson(Map<String, dynamic> json) =>
      SaveSearchModel(
        id: json["id"],
        name: json["name"],
        filters: Filters.fromJson(json["filters"]),
        comment: json["comment"] ?? "null",
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );
  int id;
  String name;
  Filters filters;
  String comment;
  DateTime createdAt;
  DateTime updatedAt;
}

class Filters {

  Filters({
    this.track,
    this.placedAtTrack,
    this.placedLastStart,
    this.placedAtDistance,
    this.barrier,
    this.oddsRange,
    this.winsAtTrack,
    this.wonLastStart,
    this.winAtDistance,
    this.jockeyHorseWins,
    this.wonLast12Months,
    this.jockeyStrikeRateLast12Months,
  });

  factory Filters.fromJson(Map<String, dynamic> json) => Filters(
    track: json["track"],
    placedAtTrack: json["placed_at_track"]?.toString(),
    placedLastStart: json["placed_last_start"] as bool? ?? false,
    placedAtDistance: json["placed_at_distance"] as bool? ?? false,
    barrier: json["barrier"],
    oddsRange: json["odds_range"],
    winsAtTrack: json["wins_at_track"],
    wonLastStart: json["won_last_start"] as bool? ?? false,
    winAtDistance: json["win_at_distance"] as bool? ?? false,
    jockeyHorseWins: json["jockey_horse_wins"],
    wonLast12Months: json["won_last_12_months"] as bool? ?? false,
    jockeyStrikeRateLast12Months: json["jockey_strike_rate_last_12_months"],
  );
  bool? placedLastStart,
      wonLastStart,
      wonLast12Months;
  String? track,
      placedAtTrack,
      barrier,
      oddsRange,
      winsAtTrack,
      jockeyHorseWins,
      jockeyStrikeRateLast12Months;
  bool? placedAtDistance, winAtDistance;

  /// Converts Filters to a map of filter keys and their values
  /// Only includes filters that have non-null values
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = {};
    if (track != null && track!.isNotEmpty) {
      map["track"] = track;
    }
    if (placedAtTrack != null && placedAtTrack!.isNotEmpty) {
      map["placed_at_track"] = placedAtTrack;
    }
    if (placedLastStart != null) {
      map["placed_last_start"] = placedLastStart;
    }
    if (placedAtDistance == true) {
      map["placed_at_distance"] = true;
    }
    if (barrier != null && barrier!.isNotEmpty) {
      map["barrier"] = barrier;
    }
    if (oddsRange != null && oddsRange!.isNotEmpty) {
      map["odds_range"] = oddsRange;
    }
    if (winsAtTrack != null && winsAtTrack!.isNotEmpty) {
      map["wins_at_track"] = winsAtTrack;
    }
    if (wonLastStart != null) {
      map["won_last_start"] = wonLastStart;
    }
    if (winAtDistance == true) {
      map["win_at_distance"] = true;
    }
    if (jockeyHorseWins != null && jockeyHorseWins!.isNotEmpty) {
      map["jockey_horse_wins"] = jockeyHorseWins;
    }
    if (wonLast12Months != null) {
      map["won_last_12_months"] = wonLast12Months;
    }
    if (jockeyStrikeRateLast12Months != null &&
        jockeyStrikeRateLast12Months!.isNotEmpty) {
      map["jockey_strike_rate_last_12_months"] = jockeyStrikeRateLast12Months;
    }
    return map;
  }
}
