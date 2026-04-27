import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:quiz_app/core/consts.dart';
import 'package:quiz_app/features/quiz_feature/cubit/cubit/quiz_cubit.dart';

import 'package:quiz_app/features/quiz_feature/screens/add_question_screen.dart';
import 'package:quiz_app/features/quiz_feature/screens/quizscreen.dart';
import 'package:quiz_app/features/quiz_feature/widgets/custombutton.dart';
import 'package:quiz_app/features/quiz_feature/widgets/customicon.dart';
import 'package:quiz_app/l10n/generated/app_localizations.dart' as ln10n10;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Quiz Master",
          style: TextStyle(color: AppConsts.primarycolor),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<QuizCubit, QuizStates>(
        builder: (context, state) {
          final isLoading = state is QuizLoadingstate;

          return Center(
            child: Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(40),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppConsts.primarycolor,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomIcon(radius: 50, icon: Icons.lightbulb_rounded),
                  SizedBox(height: 20),
                  Text(
                    "Ready for a challenge?",
                    style: TextStyle(
                      fontSize: 23,
                      color: AppConsts.secondarycolor,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "test your knowledge across +20 categories and climb the global leaderboard!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppConsts.secondarycolor,
                    ),
                  ),
                  SizedBox(height: 20),
                  if (isLoading)
                    CircularProgressIndicator(color: AppConsts.secondarycolor)
                  else if (QuizCubit.questions.isEmpty)
                    CustomButton(
                      text: "Reload Questions",
                      backgroundColor: AppConsts.secondarycolor,
                      textColor: AppConsts.primarycolor,
                      onPressed: () {
                        context.read<QuizCubit>().loadQuestions();
                      },
                    )
                  else
                    Column(
                      children: [
                        CustomButton(
                          text: "Start Quiz Now",
                          backgroundColor: AppConsts.secondarycolor,
                          textColor: AppConsts.primarycolor,
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return Quizscreen();
                                },
                              ),
                              (route) => false,
                            );
                          },
                        ),
                        SizedBox(height: 12),
                        CustomButton(
                          text: ln10n10.AppLocalizations.of(
                            context,
                          )!.addQuestion,
                          backgroundColor: AppConsts.secondarycolor,
                          textColor: AppConsts.primarycolor,
                          icon: Icons.add_circle_outline_rounded,
                          iconcolor: AppConsts.primarycolor,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddQuestionScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
