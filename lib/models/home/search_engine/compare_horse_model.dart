class CompareHorseModel {
  final String? summary, horseName, raceInfo;

  CompareHorseModel({this.summary, this.horseName, this.raceInfo});

  factory CompareHorseModel.fromJson(Map<String, dynamic> json) {
    return CompareHorseModel(
      summary: json['summary'],
      horseName: json['horse_name'],
      raceInfo: json['horse_name'],
    );
  }
}