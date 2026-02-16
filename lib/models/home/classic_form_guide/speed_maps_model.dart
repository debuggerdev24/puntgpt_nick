class SpeedMapsModel {
  SpeedMapsModel({
    required this.raceId,
    required this.raceNumber,
    required this.raceName,
    required this.distance,
    required this.meetingName,
    required this.speedMapsList,
  });

  factory SpeedMapsModel.fromJson(Map<String, dynamic> json) => SpeedMapsModel(
    raceId: (json["race_id"] as int?) ?? 0,
    raceNumber: (json["race_number"] as int?) ?? 0,
    raceName: (json["race_name"] as String?) ?? "",
    distance: (json["distance"] as int?) ?? 0,
    meetingName: (json["meeting_name"] as String?) ?? "",
    speedMapsList:
        (json["speed_maps"] as List<dynamic>?)
            ?.map((x) => SpeedMap.fromJson(x as Map<String, dynamic>))
            .toList() ??
        [],
  );
  int raceId;
  int raceNumber;
  String raceName;
  int distance;
  String meetingName;
  List<SpeedMap> speedMapsList;

  Map<String, dynamic> toJson() => {
    "race_id": raceId,
    "race_number": raceNumber,
    "race_name": raceName,
    "distance": distance,
    "meeting_name": meetingName,
    "speed_maps": List<dynamic>.from(speedMapsList.map((x) => x.toJson())),
  };
}

class SpeedMap {
  SpeedMap({
    required this.selection,
    required this.barrierSpeedMeasure,
    required this.barrierNormalisedSpeedMeasure,
    required this.barrierSpeedLabel,
    required this.settlingLength,
    required this.settlingWidth,
    required this.settlingSpeedLabel,
    required this.closingSpeedMeasure,
    required this.closingSpeedLabel,
  });

  factory SpeedMap.fromJson(Map<String, dynamic> json) => SpeedMap(
    selection: Selection.fromJson(json["selection"]),
    barrierSpeedMeasure: json["barrier_speed_measure"],
    barrierNormalisedSpeedMeasure: json["barrier_normalised_speed_measure"],
    barrierSpeedLabel: json["barrier_speed_label"],
    settlingLength: json["settling_length"],
    settlingWidth: json["settling_width"],
    settlingSpeedLabel: json["settling_speed_label"],
    closingSpeedMeasure: json["closing_speed_measure"],
    closingSpeedLabel: json["closing_speed_label"],
  );
  Selection selection;
  String barrierSpeedMeasure;
  String barrierNormalisedSpeedMeasure;
  String barrierSpeedLabel;
  int settlingLength;
  int settlingWidth;
  String settlingSpeedLabel;
  String closingSpeedMeasure;
  String closingSpeedLabel;

  Map<String, dynamic> toJson() => {
    "selection": selection.toJson(),
    "barrier_speed_measure": barrierSpeedMeasure,
    "barrier_normalised_speed_measure": barrierNormalisedSpeedMeasure,
    "barrier_speed_label": barrierSpeedLabel,
    "settling_length": settlingLength,
    "settling_width": settlingWidth,
    "settling_speed_label": settlingSpeedLabel,
    "closing_speed_measure": closingSpeedMeasure,
    "closing_speed_label": closingSpeedLabel,
  };
}

class Selection {
  Selection({
    required this.selectionId,
    required this.number,
    required this.barrier,
    required this.horse,
    required this.jockey,
    required this.trainer,
    required this.silksImage,
    required this.unibetFixedOddsWin,
  });

  factory Selection.fromJson(Map<String, dynamic> json) => Selection(
    selectionId: json["selectionId"],
    number: json["number"],
    barrier: json["barrier"],
    horse: Horse.fromJson(json["horse"]),
    jockey: Jockey.fromJson(json["jockey"]),
    trainer: Trainer.fromJson(json["trainer"]),
    silksImage: json["silks_image"],
    unibetFixedOddsWin: json["unibet_fixed_odds_win"],
  );
  int selectionId;
  int number;
  int barrier;
  Horse horse;
  Jockey jockey;
  Trainer trainer;
  String silksImage;
  String unibetFixedOddsWin;

  Map<String, dynamic> toJson() => {
    "selectionId": selectionId,
    "number": number,
    "barrier": barrier,
    "horse": horse.toJson(),
    "jockey": jockey.toJson(),
    "trainer": trainer.toJson(),
    "silks_image": silksImage,
    "unibet_fixed_odds_win": unibetFixedOddsWin,
  };
}

class Horse {
  Horse({required this.horseId, required this.name});

  factory Horse.fromJson(Map<String, dynamic> json) =>
      Horse(horseId: json["horse_id"], name: json["name"]);
  int horseId;
  String name;

  Map<String, dynamic> toJson() => {"horse_id": horseId, "name": name};
}

class Jockey {
  Jockey({required this.jockeyId, required this.name});

  factory Jockey.fromJson(Map<String, dynamic> json) =>
      Jockey(jockeyId: json["jockey_id"], name: json["name"]);
  int jockeyId;
  String name;

  Map<String, dynamic> toJson() => {"jockey_id": jockeyId, "name": name};
}

class Trainer {
  Trainer({required this.trainerId, required this.name});

  factory Trainer.fromJson(Map<String, dynamic> json) =>
      Trainer(trainerId: json["trainer_id"], name: json["name"]);
  int trainerId;
  String name;

  Map<String, dynamic> toJson() => {"trainer_id": trainerId, "name": name};
}
