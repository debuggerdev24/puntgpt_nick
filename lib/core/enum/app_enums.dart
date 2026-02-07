enum AppEnum {
  monthlyPlan,
  yearlyPlan,
  lifeTimePlan,
}

enum JumpType {
    jumps_within_10mins("Jumps within 10mins"),
  jumps_within_an_hour("Jumps within an hour"),
  jumps_today("Jumps today"),
  jumps_tomorrow("Jumps tomorrow");

  final String value;
  // ignore: sort_constructors_first
  const JumpType(this.value);

}


enum TrackType {
  placed_last_start("Placed last start"),
  placed_at_distance("Placed at distance"),
  placed_at_track("Placed at track"),
  won_last_start("Won last start"),
  won_last_12_months("Won last 12 months");

  final dynamic value;
  // ignore: sort_constructors_first
  const TrackType(this.value);
}
