abstract class MeditationEvent {}

class FetchDailyQuote extends MeditationEvent {}

class FetchMoodMessage extends MeditationEvent {
  final String mood;

  FetchMoodMessage({required this.mood});
}
