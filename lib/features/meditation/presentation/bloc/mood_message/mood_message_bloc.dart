import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rise_above/features/meditation/domain/usecases/get_mood_message.dart';
import 'package:rise_above/features/meditation/presentation/bloc/mood_message/mood_message_event.dart';
import 'package:rise_above/features/meditation/presentation/bloc/mood_message/mood_message_state.dart';

class MoodMessageBloc extends Bloc<MoodMessageEvent, MoodMessageState> {
  final GetMoodMessage getMoodMessage;
  MoodMessageLoaded? _lastMoodMessage; // Store the last loaded message

  MoodMessageBloc({required this.getMoodMessage})
    : super(MoodMessageInitial()) {
    on<FetchMessageEvent>((event, emit) async {
      emit(MoodMessageLoading());

      try {
        final moodMessage = await getMoodMessage(event.mood);
        _lastMoodMessage = MoodMessageLoaded(moodMessage: moodMessage);
        emit(_lastMoodMessage!);
      } catch (e) {
        emit(
          MoodMessageError(
            message: "Oops! Something went wrong. Please try again later.",
          ),
        );
      }
    });

    on<ResetMoodMessage>((event, emit) async {
      // Provide a short delay before resetting for better UX
      await Future.delayed(Duration(milliseconds: 500));
      emit(MoodMessageInitial());
    });
  }
}
