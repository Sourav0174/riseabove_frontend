import 'package:rise_above/features/meditation/domain/entities/mood_message.dart';
import 'package:rise_above/features/meditation/domain/repositories/meditation_repository.dart';
import 'package:rise_above/features/meditation/presentation/pages/meditation_page.dart';

class GetMoodMessage {
  final MeditationRepository repository;
  GetMoodMessage({required this.repository});

  Future<MoodMessage> call(String mood) async {
    return await repository.getMoodMessage(mood);
  }
}
