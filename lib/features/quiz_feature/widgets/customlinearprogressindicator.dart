import 'package:flutter/material.dart';
import 'package:quiz_app/core/consts.dart';
import 'package:quiz_app/features/quiz_feature/models/questionmodel.dart';

class CustomLinearProgressIndicator extends StatelessWidget {
  const CustomLinearProgressIndicator({
    super.key,
    required this.questionsindex,
  });

  final int questionsindex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Text(
              "Question $questionsindex of ${questions.length}",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),

            Text(
              "${(questionsindex * 10)}% complete",
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
          value: questionsindex / 10,
          color: AppConsts.primarycolor,
          backgroundColor: AppConsts.primarycolor.withValues(alpha: .15),
          minHeight: 10,
          borderRadius: BorderRadius.circular(5),
        ),
      ],
    );
  }
}
