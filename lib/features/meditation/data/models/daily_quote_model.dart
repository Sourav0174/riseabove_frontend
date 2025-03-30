// import 'package:rise_above/features/meditation/domain/entities/daily_quote.dart';

// class DailyQuoteModel extends DailyQuote {
//   DailyQuoteModel({
//     required super.morningQuote,
//     required super.noonQuote,
//     required super.eveningQuote,
//   });

//   factory DailyQuoteModel.fromJson(Map<String, dynamic> json) {
//     return DailyQuoteModel(
//       morningQuote: json["morning"] ?? "No morning quote available",
//       noonQuote: json["afternoon"] ?? "No noon quote available",
//       eveningQuote: json["evening"] ?? "No evening quote available",
//     );
//   }
// }

import 'package:rise_above/features/meditation/domain/entities/daily_quote.dart';

class DailyQuoteModel extends DailyQuote {
  DailyQuoteModel({
    required super.morningQuote,
    required super.noonQuote,
    required super.eveningQuote,
  });

  /// Factory constructor to create a [DailyQuoteModel] from JSON
  factory DailyQuoteModel.fromJson(Map<String, dynamic> json) {
    return DailyQuoteModel(
      morningQuote: json["morning"] ?? "No morning quote available",
      noonQuote: json["afternoon"] ?? "No noon quote available",
      eveningQuote: json["evening"] ?? "No evening quote available",
    );
  }

  /// Converts [DailyQuoteModel] to JSON format
  Map<String, dynamic> toJson() {
    return {
      "morning": morningQuote,
      "afternoon": noonQuote,
      "evening": eveningQuote,
    };
  }
}
