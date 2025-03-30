import 'package:equatable/equatable.dart';
import 'package:rise_above/features/meditation/domain/entities/daily_quote.dart';

abstract class DailyQuoteState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DailyQuoteInitial extends DailyQuoteState {}

class DailyQuoteLoading extends DailyQuoteState {}

class DailyQuoteLoaded extends DailyQuoteState {
  final DailyQuote dailyQuote;

  DailyQuoteLoaded({required this.dailyQuote});

  @override
  List<Object> get props => [dailyQuote];
}

class DailyQuoteError extends DailyQuoteState {
  final String message;

  DailyQuoteError({required this.message});

  @override
  List<Object> get props => [message];
}
