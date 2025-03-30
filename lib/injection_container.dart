import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:rise_above/features/meditation/data/datasources/meditation_remote_datasource.dart';
import 'package:rise_above/features/meditation/data/repositories/meditation_repository_impl.dart';
import 'package:rise_above/features/meditation/domain/repositories/meditation_repository.dart';
import 'package:rise_above/features/meditation/domain/usecases/get_daily_quote.dart';
import 'package:rise_above/features/meditation/domain/usecases/get_mood_message.dart';
import 'package:rise_above/features/meditation/presentation/bloc/daily_quote/daily_quote_bloc.dart';
import 'package:rise_above/features/meditation/presentation/bloc/meditation/meditation_bloc.dart';
import 'package:rise_above/features/meditation/presentation/bloc/mood_message/mood_message_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External Dependencies
  sl.registerLazySingleton(() => http.Client());

  // Data Sources
  sl.registerLazySingleton<MeditationRemoteDatasource>(
    () => MeditationRemoteDatasourceImpl(client: sl()),
  );
  // sl.registerLazySingleton<SongRemoteDataSource>(

  // Repositories
  sl.registerLazySingleton<MeditationRepository>(
    () => MeditationRepositoryImpl(remoteDatasource: sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetDailyQuote(repository: sl()));
  sl.registerLazySingleton(() => GetMoodMessage(repository: sl()));
  // sl.registerLazySingleton(() => GetAllSongs(repository: sl()));

  // Blocs
  sl.registerFactory(() => DailyQuoteBloc(getDailyQuote: sl()));
  sl.registerFactory(() => MoodMessageBloc(getMoodMessage: sl()));
  // sl.registerFactory(() => SongBloc(getAllSongs: sl()));
  sl.registerFactory(
    () => MeditationBloc(getDailyQuote: sl(), getMoodMessage: sl()),
  );
}
