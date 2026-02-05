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
  const JumpType(this.value);

}


enum TrackType {
  placed_last_start("placed_last_start"),
  placed_at_distance("placed_at_distance"),
  placed_at_track("placed_at_track");

  final String value;
  const TrackType(this.value);
}
