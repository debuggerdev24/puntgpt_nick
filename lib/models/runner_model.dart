class RunnerModel {
  RunnerModel({
    required this.label,
    required this.price,
    required this.date,
    required this.numberOfRace,
    required this.nextRaceRemainTime,
    required this.number,
  });

  factory RunnerModel.fromJson(Map json) {
    return RunnerModel(
      label: json["label"],
      price: json["price"],
      date: json["date"],
      numberOfRace: json["numberOfRace"],
      nextRaceRemainTime: json["nextRaceRemainTime"],
      number: json["number"],
    );
  }
  String label, price, date, nextRaceRemainTime;
  int number, numberOfRace;
}
