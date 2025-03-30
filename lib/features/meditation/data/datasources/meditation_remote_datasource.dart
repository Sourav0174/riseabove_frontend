import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rise_above/features/meditation/data/models/daily_quote_model.dart';
import 'package:rise_above/features/meditation/data/models/mood_message_model.dart';

abstract class MeditationRemoteDatasource {
  Future<DailyQuoteModel> getDailyQuote();
  Future<MoodMessageModel> getMoodMessage(String mood);
}

class MeditationRemoteDatasourceImpl extends MeditationRemoteDatasource {
  final http.Client client;

  MeditationRemoteDatasourceImpl({required this.client});

  @override
  Future<DailyQuoteModel> getDailyQuote() async {
    try {
      final response = await client.get(
        Uri.parse(
          "api",
        ),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return DailyQuoteModel.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to load daily quote: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error fetching daily quote: $e');
    }
  }

  @override
  Future<MoodMessageModel> getMoodMessage(String mood) async {
    try {
      final response = await client.get(
        Uri.parse(
          "api",
        ),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        print("mood: ${jsonEncode(jsonResponse)}"); // Corrected print statement
        return MoodMessageModel.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to load mood quote: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error fetching mood message: $e');
    }
  }
}
