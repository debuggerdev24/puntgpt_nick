class MeetingDetailsModel {
  factory MeetingDetailsModel.fromJson(Map<String, dynamic> json) {
    final racesRaw = json["races"];
    final racesList = racesRaw is List
        ? racesRaw
        : (racesRaw is Map ? racesRaw.values.toList() : <dynamic>[]);
    return MeetingDetailsModel(
      meeting: Meeting.fromJson(json["meeting"] as Map<String, dynamic>),
      races: List<Race>.from(
        racesList.map((x) => Race.fromJson(x as Map<String, dynamic>)),
      ),
      raceCount: json["race_count"],
      meetingDate: json["meeting_date"] as String,
    );
  }

  MeetingDetailsModel({
    required this.meeting,
    required this.races,
    required this.raceCount,
    required this.meetingDate,
  });
  Meeting meeting;
  List<Race> races;
  int raceCount;
  String meetingDate;
}

class Meeting {
  factory Meeting.fromJson(Map<String, dynamic> json) => Meeting(
    meetingId: json["meetingId"],
    date: json["date"],
    trackName: json["track_name"],
    trackCountry: json["track_country"],
    name: json["name"],
    railPosition: json["rail_position"],
  );

  Meeting({
    required this.meetingId,
    required this.date,
    required this.trackName,
    required this.trackCountry,
    required this.name,
    required this.railPosition,
  });
  int meetingId;

  String trackName, date, trackCountry, name, railPosition;
}

class Race {
  factory Race.fromJson(Map<String, dynamic> json) => Race(
    number: json["number"],
    raceId: json["raceId"],
    name: json["name"],
    distance: json["distance"],
    distanceUnits: json["distance_units"],
    startTimeUtc: json["startTimeUtc"],
  );

  Race({
    required this.number,
    required this.raceId,
    required this.name,
    required this.distance,
    required this.distanceUnits,
    required this.startTimeUtc,
  });
  int number, raceId, distance;
  String name, distanceUnits, startTimeUtc;
}
