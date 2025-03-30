import 'package:rise_above/features/meditation/presentation/bloc/daily_quote/daily_quote_event.dart';

abstract class MoodMessageEvent {}

class FetchMessageEvent extends MoodMessageEvent {
  final String mood;
  FetchMessageEvent(this.mood);
}

class ResetMoodMessage extends MoodMessageEvent {}
