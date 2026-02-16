class TipsAnalysisModel {
  TipsAnalysisModel({
    required this.raceId,
    required this.tipAnalysisText,
    required this.tipAnalysisHtml,
    required this.tipsSourceBrand,
    required this.tipsSourceName,
    required this.tipsSourceImage,
    required this.tips,
  });

  factory TipsAnalysisModel.fromJson(Map<String, dynamic> json) =>
      TipsAnalysisModel(
        raceId: json["raceId"],
        tipAnalysisText: json["tip_analysis_text"],
        tipAnalysisHtml: json["tip_analysis_html"],
        tipsSourceBrand: json["tips_source_brand"],
        tipsSourceName: json["tips_source_name"],
        tipsSourceImage: json["tips_source_image"],
        tips: List<Tip>.from(json["tips"].map((x) => Tip.fromJson(x))),
      );
  int raceId;
  String tipAnalysisText;
  String tipAnalysisHtml;
  String tipsSourceBrand;
  String tipsSourceName;
  String tipsSourceImage;
  List<Tip> tips;
}

class Tip {
  Tip({
    required this.selectionId,
    required this.number,
    required this.barrier,
    required this.horseName,
    required this.jockeyName,
    required this.trainerName,
    required this.silksImage,
    required this.tipPosition,
    required this.isBestBet,
    required this.isBestValue,
    required this.isScratched,
    required this.unibetFixedOddsWin,
  });

  factory Tip.fromJson(Map<String, dynamic> json) => Tip(
    selectionId: json["selectionId"],
    number: json["number"],
    barrier: json["barrier"],
    horseName: json["horse_name"],
    jockeyName: json["jockey_name"],
    trainerName: json["trainer_name"],
    silksImage: json["silks_image"],
    tipPosition: json["tip_position"],
    isBestBet: json["is_best_bet"],
    isBestValue: json["is_best_value"],
    isScratched: json["isScratched"],
    unibetFixedOddsWin: json["unibet_fixed_odds_win"],
  );
  int selectionId, number, barrier, tipPosition;
  String horseName, jockeyName, trainerName, silksImage;
  bool isBestBet, isBestValue, isScratched;
  String? unibetFixedOddsWin;
}
