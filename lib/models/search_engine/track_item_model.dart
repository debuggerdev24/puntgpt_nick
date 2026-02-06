import 'package:puntgpt_nick/core/enum/app_enums.dart';

class TrackItemModel {

final TrackType trackType;
  final bool checked;

  // ignore: sort_constructors_first
  TrackItemModel({
    required this.trackType,
    this.checked = false,
  });
  
  factory TrackItemModel.fromTrackType(TrackType trackType) {
    return TrackItemModel(trackType: trackType);
  }

  TrackItemModel copyWith({
    TrackType? trackType,
    bool? checked,
  }) {
    return TrackItemModel(
      trackType: trackType ?? this.trackType,
      checked: checked ?? this.checked,
    );
  }

}

