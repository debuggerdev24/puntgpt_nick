class SaveSearchModel {
    int id;
    String name;
    Filters filters;
    String comment;
    DateTime createdAt;
    DateTime updatedAt;

    SaveSearchModel({
        required this.id,
        required this.name,
        required this.filters,
        required this.comment,
        required this.createdAt,
        required this.updatedAt,
    });

    factory SaveSearchModel.fromJson(Map<String, dynamic> json) => SaveSearchModel(
        id: json["id"],
        name: json["name"],
        filters: Filters.fromJson(json["filters"]),
        comment: json["comment"] ?? "null",
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

}

class Filters {
    String? track;
    bool? placedAtTrack;
    bool? placedLastStart;
    bool? placedAtDistance;

    Filters({
        this.track,
        this.placedAtTrack,
        this.placedLastStart,
        this.placedAtDistance,
    });

    factory Filters.fromJson(Map<String, dynamic> json) => Filters(
        track: json["track"],
        placedAtTrack: _parseBool(json["placed_at_track"]),
        placedLastStart: _parseBool(json["placed_last_start"]),
        placedAtDistance: _parseBool(json["placed_at_distance"]),
    );

    /// Helper method to parse boolean values from JSON
    /// Handles both string ("true"/"false") and boolean (true/false) values
    /// Returns null if the value is not present
    static bool? _parseBool(dynamic value) {
      if (value == null) return null;
      if (value is bool) return value;
      if (value is String) {
        return value.toLowerCase() == "true";
      }
      return null;
    }

    /// Converts Filters to a map of filter keys and their values
    /// Only includes filters that have non-null values
    Map<String, dynamic> toMap() {
      final Map<String, dynamic> map = {};
      if (track != null && track!.isNotEmpty) {
        map["track"] = track;
      }
      if (placedAtTrack != null) {
        map["placed_at_track"] = placedAtTrack;
      }
      if (placedLastStart != null) {
        map["placed_last_start"] = placedLastStart;
      }
      if (placedAtDistance != null) {
        map["placed_at_distance"] = placedAtDistance;
      }
      return map;
    }
}
