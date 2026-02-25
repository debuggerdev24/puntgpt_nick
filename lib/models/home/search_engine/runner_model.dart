class RunnerDataModel {
  factory RunnerDataModel.fromJson(Map<String, dynamic> json) {
    final runnersList = (json["runners"] as List?)
        ?.take(10)
            .map((x) => Runner.fromJson(x as Map<String, dynamic>))
            .toList() ??
        [];
        
    return RunnerDataModel(
      runnerCount: json["runner_count"],
      runnersList: runnersList,
    );
  }

  RunnerDataModel({
    this.runnerCount,
    this.runnersList = const [],
  });
  int? runnerCount;
  List<Runner> runnersList;
}

class Runner {
  Runner({
    this.selectionId,
    this.selectionNumber,
    this.horseName,
    this.jockeyName,
    this.trainerName,
    this.track,
    this.raceId,
    this.raceNumber,
    this.jumpTimeAu,
    this.silksImage,
    this.odds,
  });

  factory Runner.fromJson(Map<String, dynamic> json) => Runner(
        selectionId: json["selection_id"],
        selectionNumber: json["selection_number"],
        horseName: json["horse_name"],
        jockeyName: json["jockey_name"] ?? "Jockey Name",
        trainerName: json["trainer_name"],
        track: json["track"],
        raceId: json["race_id"],
        raceNumber: json["race_number"],
        jumpTimeAu: json["jump_time_au"],
        silksImage: json["silks_image"],
        odds: json["odds"] != null
            ? (json["odds"] is num
                ? (json["odds"] as num).toDouble()
                : double.tryParse(json["odds"].toString()))
            : null,
      );

  int? selectionId;
  int? selectionNumber;
  String? horseName;
  String? jockeyName;
  String? trainerName;
  String? track;
  int? raceId;
  int? raceNumber;
  String? jumpTimeAu,silksImage;
  double? odds;
}
