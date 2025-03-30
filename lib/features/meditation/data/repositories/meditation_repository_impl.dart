import 'package:rise_above/features/meditation/data/datasources/meditation_remote_datasource.dart';
import 'package:rise_above/features/meditation/domain/entities/daily_quote.dart';
import 'package:rise_above/features/meditation/domain/entities/mood_message.dart';
import 'package:rise_above/features/meditation/domain/repositories/meditation_repository.dart';

class MeditationRepositoryImpl implements MeditationRepository {
  final MeditationRemoteDatasource remoteDatasource;

  MeditationRepositoryImpl({required this.remoteDatasource});

  @override
  Future<DailyQuote> getDailyQuote() async {
    try {
      return await remoteDatasource.getDailyQuote();
    } catch (e) {
      throw Exception("Failed to fetch daily quote: ${e.toString()}");
    }
  }

  @override
  Future<MoodMessage> getMoodMessage(String mood) async {
    try {
      return await remoteDatasource.getMoodMessage(mood);
    } catch (e) {
      throw Exception("Failed to fetch mood message: ${e.toString()}");
    }
  }
}
