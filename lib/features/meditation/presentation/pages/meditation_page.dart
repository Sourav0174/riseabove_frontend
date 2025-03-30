import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rise_above/core/theme.dart';
import 'package:rise_above/features/meditation/presentation/bloc/daily_quote/daily_quote_bloc.dart';
import 'package:rise_above/features/meditation/presentation/bloc/daily_quote/daily_quote_state.dart';
import 'package:rise_above/features/meditation/presentation/bloc/mood_message/mood_message_bloc.dart';
import 'package:rise_above/features/meditation/presentation/bloc/mood_message/mood_message_event.dart';
import 'package:rise_above/features/meditation/presentation/bloc/mood_message/mood_message_state.dart';
import 'package:rise_above/features/meditation/presentation/widgets/feeling_button.dart';
import 'package:rise_above/features/meditation/presentation/widgets/task_card.dart';

class MeditationPage extends StatelessWidget {
  const MeditationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          "Rise Above",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF3EADCF), Color(0xFFABE9CD)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 4,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              _buildHeaderText("Welcome, How are you feeling today?"),
              const SizedBox(height: 20),
              _buildSubHeaderText("Select your mood"),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildFeelingButton(
                    context,
                    "Happy",
                    "assets/images/feeling/happy_emoji.png",
                    AppColors.happy,
                    "Today I am happy",
                  ),
                  _buildFeelingButton(
                    context,
                    "Motivated",
                    "assets/images/feeling/motivated_emoji.png",
                    AppColors.motivated,
                    "Today I am feeling motivated",
                  ),
                  _buildFeelingButton(
                    context,
                    "Calm",
                    "assets/images/feeling/calm_emoji.png",
                    AppColors.calm,
                    "Today I am calm",
                  ),
                ],
              ),
              const SizedBox(height: 30),
              _buildSubHeaderText("Today's Mindfulness Task"),
              const SizedBox(height: 16),
              BlocBuilder<DailyQuoteBloc, DailyQuoteState>(
                builder: (context, state) {
                  if (state is DailyQuoteLoaded) {
                    return Column(
                      children: [
                        _buildTaskCard(
                          "Morning Reflection",
                          state.dailyQuote.morningQuote,
                          AppColors.taskMorning,
                        ),
                        const SizedBox(height: 12),
                        _buildTaskCard(
                          "Midday Reset",
                          state.dailyQuote.noonQuote,
                          AppColors.taskNoon,
                        ),
                        const SizedBox(height: 12),
                        _buildTaskCard(
                          "Evening Gratitude",
                          state.dailyQuote.eveningQuote,
                          AppColors.taskEvening,
                        ),
                      ],
                    );
                  } else if (state is DailyQuoteError) {
                    return Center(child: _buildSubHeaderText(state.message));
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
              const SizedBox(height: 30),
              _buildSubHeaderText("Relax with a Breathing Exercise"),
              const SizedBox(height: 16),
              _buildBreathingExerciseCard(),
              const SizedBox(height: 32),
              BlocListener<MoodMessageBloc, MoodMessageState>(
                listener: (context, state) {
                  if (state is MoodMessageLoading) {
                    showDialog(
                      context: context,
                      builder:
                          (context) =>
                              const Center(child: CircularProgressIndicator()),
                    );
                  } else if (state is MoodMessageLoaded) {
                    Navigator.pop(context); // Close the previous loading dialog

                    showDialog(
                      context: context,
                      builder:
                          (context) => AlertDialog(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            title: _buildSubHeaderText(
                              'Here’s an uplifting message for you',
                            ),
                            content: Text(
                              state.moodMessage.text,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  context.read<MoodMessageBloc>().add(
                                    ResetMoodMessage(),
                                  );
                                },
                                child: const Text(
                                  'OK',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ],
                          ),
                    );
                  }
                },
                child: const SizedBox.shrink(),
              ),

              // BlocListener<MoodMessageBloc, MoodMessageState>(
              //   listener: (context, state) {
              //     if (state is MoodMessageLoaded) {
              //       showDialog(
              //         context: context,
              //         builder:
              //             (context) => AlertDialog(
              //               backgroundColor: Colors.white,
              //               shape: RoundedRectangleBorder(
              //                 borderRadius: BorderRadius.circular(12),
              //               ),
              //               title: _buildSubHeaderText(
              //                 'Here’s an uplifting message for you',
              //               ),
              //               content: Text(
              //                 state.moodMessage.text,
              //                 style: TextStyle(
              //                   fontSize: 14,
              //                   color: Colors.black,
              //                 ),
              //               ),
              //               actions: [
              //                 TextButton(
              //                   onPressed: () {
              //                     Navigator.pop(context);
              //                     context.read<MoodMessageBloc>().add(
              //                       ResetMoodMessage(),
              //                     );
              //                   },
              //                   child: const Text(
              //                     'OK',
              //                     style: TextStyle(color: Colors.blue),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //       );
              //     }
              //   },
              //   child: const SizedBox.shrink(),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: const Color.fromARGB(255, 68, 68, 68),
      ),
    );
  }

  Widget _buildSubHeaderText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.black54,
      ),
    );
  }

  Widget _buildFeelingButton(
    BuildContext context,
    String label,
    String image,
    Color color,
    String moodText,
  ) {
    return GestureDetector(
      onTap:
          () =>
              context.read<MoodMessageBloc>().add(FetchMessageEvent(moodText)),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  offset: Offset(3, 3),
                  blurRadius: 5,
                  color: Colors.black12,
                ),
              ],
            ),
            child: Center(child: Image.asset(image, width: 40)),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskCard(String title, String description, Color color) {
    return TaskCard(color: color, title: title, description: description);
  }

  Widget _buildBreathingExerciseCard() {
    return GestureDetector(
      onTap: () {
        // Open breathing exercise screen
      },
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF84FAB0), Color(0xFF8FD3F4)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              offset: Offset(4, 4),
              blurRadius: 6,
              color: Colors.black12,
            ),
          ],
        ),
        child: Center(
          child: _buildSubHeaderText("Tap to Start a 1-Min Breathing Exercise"),
        ),
      ),
    );
  }
}
