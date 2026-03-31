class ClassicFormModel {
  ClassicFormModel({
    required this.meetingId,
    required this.meetingName,
    required this.trackName,
    required this.meetingDate,
    required this.races,
    required this.meetingAustralianTime,
    required this.country,
  });

  factory ClassicFormModel.fromJson(Map<String, dynamic> json) =>
      ClassicFormModel(
        country: (json["country"] as String?) ?? "",
        meetingId: (json["meeting_id"] as int?) ?? 0,
        meetingName: (json["meeting_name"] as String?) ?? "",
        trackName: (json["track_name"] as String?) ?? "",
        meetingDate: (json["meeting_date"] as String?) ?? "",
        meetingAustralianTime:
            (json["meeting_australian_time"] as String?) ?? "",
        races:
            (json["races"] as List<dynamic>?)
                ?.map((x) => Race.fromJson(x as Map<String, dynamic>))
                .toList() ??
            [],
      );
  int meetingId;
  String meetingName, trackName, meetingDate, meetingAustralianTime,country;
  List<Race> races;
}

class Race {
  Race({
    required this.raceId,
    required this.raceName,
    required this.raceNumber,
    required this.raceTimeUtc,
    required this.raceAustralianTime,
  });

  factory Race.fromJson(Map<String, dynamic> json) {
    final raceTimeUtc = json["race_time_utc"] ?? json["raceTimeUtc"];
    return Race(
      raceId: (json["race_id"] ?? json["raceId"]) as int? ?? 0,
      raceName: (json["race_name"] ?? json["raceName"]) as String? ?? "",
      raceNumber: (json["race_number"] ?? json["raceNumber"]) as int? ?? 0,
      raceTimeUtc: raceTimeUtc != null
          ? DateTime.tryParse(raceTimeUtc.toString()) ?? DateTime.now()
          : DateTime.now(),
      raceAustralianTime:
          (json["race_australian_time"] ?? json["raceAustralianTime"])
              as String? ??
          "",
    );
  }
  int raceId, raceNumber;
  DateTime raceTimeUtc;
  String raceAustralianTime, raceName;

  Map<String, dynamic> toJson() => {
    "raceId": raceId,
    "race_name": raceName,
    "race_number": raceNumber,
    "race_time_utc": raceTimeUtc.toIso8601String(),
    "race_australian_time": raceAustralianTime,
  };
}
