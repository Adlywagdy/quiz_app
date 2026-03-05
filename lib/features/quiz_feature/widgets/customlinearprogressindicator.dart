import 'package:flutter/material.dart';
import 'package:quiz_app/core/consts.dart';
import 'package:quiz_app/features/quiz_feature/cubit/cubit/quiz_cubit.dart';

class CustomLinearProgressIndicator extends StatelessWidget {
  const CustomLinearProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Text(
              "Question ${QuizCubit.questionindex} of ${QuizCubit.questions.length}",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),

            Text(
              "${(QuizCubit.questionindex * 10)}% complete",
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
          value: QuizCubit.questionindex / 10,
          color: AppConsts.primarycolor,
          backgroundColor: AppConsts.primarycolor.withValues(alpha: .15),
          minHeight: 10,
          borderRadius: BorderRadius.circular(5),
        ),
      ],
    );
  }
}
