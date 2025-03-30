import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rise_above/features/meditation/domain/usecases/get_daily_quote.dart';
import 'package:rise_above/features/meditation/presentation/bloc/daily_quote/daily_quote_event.dart';
import 'package:rise_above/features/meditation/presentation/bloc/daily_quote/daily_quote_state.dart';

class DailyQuoteBloc extends Bloc<DailyQuoteEvent, DailyQuoteState> {
  final GetDailyQuote getDailyQuote;

  DailyQuoteBloc({required this.getDailyQuote}) : super(DailyQuoteInitial()) {
    on<FetchDailyQuotes>(_onFetchDailyQuotes);
  }

  Future<void> _onFetchDailyQuotes(
    FetchDailyQuotes event,
    Emitter<DailyQuoteState> emit,
  ) async {
    emit(DailyQuoteLoading());

    try {
      final dailyQuote = await getDailyQuote();
      emit(DailyQuoteLoaded(dailyQuote: dailyQuote));
    } catch (error) {
      emit(DailyQuoteError(message: error.toString()));
    }
  }
}
