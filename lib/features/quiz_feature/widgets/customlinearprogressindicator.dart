import 'package:flutter/material.dart';
import 'package:quiz_app/core/consts.dart';
import 'package:quiz_app/features/quiz_feature/cubit/cubit/quiz_cubit.dart';

class CustomLinearProgressIndicator extends StatelessWidget {
  const CustomLinearProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final totalQuestions = QuizCubit.questions.length;
    final currentQuestion = totalQuestions == 0
        ? 0
        : QuizCubit.questionindex + 1;
    final progressValue = totalQuestions == 0
        ? 0.0
        : currentQuestion / totalQuestions;

    return Column(
      children: [
        Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Text(
              "Question $currentQuestion of $totalQuestions",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),

            Text(
              "${(progressValue * 100).toStringAsFixed(0)}% complete",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppConsts.greycolor,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        LinearProgressIndicator(
          value: progressValue,
          color: AppConsts.primarycolor,
          backgroundColor: AppConsts.primarycolor.withValues(alpha: .15),
          minHeight: 10,
          borderRadius: BorderRadius.circular(5),
        ),
      ],
    );
  }
}
