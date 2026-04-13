class ClassicFormModel {
  ClassicFormModel({
    required this.meetingId,
    required this.meetingName,
    required this.trackName,
    required this.meetingDate,
    required this.races,
    required this.meetingAustralianTime,
    required this.country,
    required this.railPosition,
    required this.weatherEmoji,
    required this.weatherCondition,
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
        railPosition: json["rail_position"],
        weatherEmoji: json["weather_emoji"],
        weatherCondition: json["weather_condition"] ,
      );
  int meetingId;
  String meetingName,
      trackName,
      meetingDate,
      meetingAustralianTime,
      country,
      railPosition,weatherEmoji,weatherCondition;
  List<Race> races;
}

class Race {
  Race({
    required this.raceId,
    required this.raceName,
    required this.raceNumber,
    required this.raceTimeUtc,
    required this.raceAustralianTime,
    required this.trackCondition,
  });

  factory Race.fromJson(Map<String, dynamic> json) {

    return Race(
      raceId: (json["race_id"] ?? json["raceId"]) as int? ?? 0,
      raceName: (json["race_name"] ?? json["raceName"]) as String? ?? "",
      raceNumber: (json["race_number"] ?? json["raceNumber"]) as int? ?? 0,
      raceTimeUtc: json["race_australian_time"] ?? "",
      raceAustralianTime:json["race_australian_time"] ?? "",
      trackCondition: json["track_condition"] ?? "",
    );
  }
  int raceId, raceNumber;

  String raceAustralianTime, raceName,raceTimeUtc,trackCondition;

}
