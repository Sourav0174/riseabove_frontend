import 'package:rise_above/features/meditation/domain/entities/daily_quote.dart';
import 'package:rise_above/features/meditation/domain/repositories/meditation_repository.dart';
import 'package:rise_above/features/meditation/presentation/pages/meditation_page.dart';

class GetDailyQuote {
  final MeditationRepository repository;

  GetDailyQuote({required this.repository});

  Future<DailyQuote> call() async {
    return repository.getDailyQuote();
  }
}
