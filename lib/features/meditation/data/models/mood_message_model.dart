import 'package:rise_above/features/meditation/domain/entities/mood_message.dart';

class MoodMessageModel extends MoodMessage {
  MoodMessageModel({required super.text});

  /// Factory constructor to create a [MoodMessageModel] from JSON
  factory MoodMessageModel.fromJson(Map<String, dynamic> json) {
    return MoodMessageModel(
      text: json['advice'] ?? "No mood message available",
    );
  }

  /// Converts [MoodMessageModel] to JSON format
  Map<String, dynamic> toJson() {
    return {"text": text};
  }
}
