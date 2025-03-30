import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rise_above/features/meditation/presentation/bloc/daily_quote/daily_quote_bloc.dart';
import 'package:rise_above/features/meditation/presentation/bloc/meditation/meditation_bloc.dart';
import 'package:rise_above/features/meditation/presentation/bloc/mood_message/mood_message_bloc.dart';
import 'package:rise_above/features/meditation/presentation/pages/meditation_page.dart';
import 'package:rise_above/injection_container.dart' as di;
import 'package:rise_above/features/meditation/presentation/bloc/daily_quote/daily_quote_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init(); // Ensure dependencies are initialized
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.sl<DailyQuoteBloc>()..add(FetchDailyQuotes()),
        ),
        BlocProvider(create: (_) => di.sl<MoodMessageBloc>()),
        BlocProvider(create: (_) => di.sl<MeditationBloc>()), // Added this line
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        themeMode: ThemeMode.system,
        home: MeditationPage(),
      ),
    );
  }
}
