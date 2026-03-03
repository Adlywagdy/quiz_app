import 'package:flutter/material.dart';
import 'package:quiz_app/core/consts.dart';
import 'package:quiz_app/features/quiz_feature/models/questionmodel.dart';
import 'package:quiz_app/features/quiz_feature/screens/quizresult.dart';
import 'package:quiz_app/features/quiz_feature/widgets/customanswersitem.dart';
import 'package:quiz_app/features/quiz_feature/widgets/custombutton.dart';
import 'package:quiz_app/features/quiz_feature/widgets/customlinearprogressindicator.dart';

class Quizscreen extends StatelessWidget {
  const Quizscreen({super.key});

  @override
  Widget build(BuildContext context) {
    int questionsindex = 0;

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz', style: TextStyle(fontWeight: .w500)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: CustomLinearProgressIndicator(
                questionsindex: questionsindex,
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 20)),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Text(
                    questions[questionsindex].question,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 15),
                ],
              ),
            ),
            SliverList.builder(
              itemCount: questions[questionsindex].options.length,
              itemBuilder: (context, index) {
                return CustomAnswersItem(
                  questionsindex: questionsindex,
                  index: index,
                );
              },
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: .end,
                children: [
                  CustomButton(
                    text: "Next  ➜",
                    backgroundColor: AppConsts.primarycolor,
                    textColor: AppConsts.secondarycolor,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return QuizResult(ispassed: false);
                          },
                        ),
                      );
                    },

                    fixedSize: WidgetStatePropertyAll(
                      Size(double.maxFinite, 50),
                    ),
                    shapecircularradius: 15,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Skip this question",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 20, 99, 164),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
