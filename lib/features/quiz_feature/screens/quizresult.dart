import 'package:flutter/material.dart';
import 'package:quiz_app/core/consts.dart';
import 'package:quiz_app/features/quiz_feature/cubit/cubit/quiz_cubit.dart';
import 'package:quiz_app/features/quiz_feature/screens/homescreen.dart';
import 'package:quiz_app/features/quiz_feature/screens/quizscreen.dart';
import 'package:quiz_app/features/quiz_feature/widgets/custombutton.dart';
import 'package:quiz_app/features/quiz_feature/widgets/customicon.dart';

class QuizResult extends StatelessWidget {
  final bool ispassed;
  const QuizResult({super.key, required this.ispassed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz Results", style: TextStyle(fontWeight: .w500)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: .center,
          children: [
            CustomIcon(
              radius: 50,
              icon: ispassed
                  ? Icons.workspace_premium_rounded
                  : Icons.error_rounded,
              iconcolor: ispassed ? AppConsts.primarycolor : Colors.red,
              backgroundColor: AppConsts.primarycolor.withValues(alpha: .1),
            ),
            SizedBox(height: 15),
            Text(
              ispassed ? "Congratulations!" : "Oh no!",
              style: TextStyle(fontSize: 30, fontWeight: .w500),
            ),
            Text(
              ispassed
                  ? "You've mastered this quiz!"
                  : "Don't worry, keep practicing and you'll get there!",
              style: TextStyle(color: AppConsts.greycolor),
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: AppConsts.secondarycolor,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(color: AppConsts.greycolor, blurRadius: 3),
                ],
              ),

              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Row(
                    crossAxisAlignment: .start,
                    children: [
                      CustomIcon(
                        radius: 10,
                        icon: Icons.star_rounded,
                        backgroundColor: ispassed
                            ? AppConsts.primarycolor
                            : Colors.red,
                        iconcolor: AppConsts.secondarycolor,
                        iconsize: 15,
                      ),
                      SizedBox(width: 8),
                      Text("Your Score"),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "${QuizCubit.score}",
                        style: TextStyle(fontSize: 30, fontWeight: .w500),
                      ),
                      Text(
                        " /${QuizCubit.questions.length}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: .w500,
                          color: AppConsts.greycolor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return ListView.builder(
                      padding: EdgeInsets.all(18),

                      itemCount: QuizCubit.failedquestions.length,
                      itemBuilder: (context, index) {
                        return Text(
                          QuizCubit.failedquestions[index].question,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        );
                      },
                    );
                  },
                );
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: AppConsts.secondarycolor,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(color: AppConsts.greycolor, blurRadius: 3),
                  ],
                ),

                child: Text("tap to see your failed questions"),
              ),
            ),
            Spacer(),
            CustomButton(
              icon: Icons.replay,
              iconcolor: AppConsts.secondarycolor,
              text: " Play Again",
              backgroundColor: AppConsts.primarycolor,
              textColor: AppConsts.secondarycolor,
              onPressed: () {
                QuizCubit.questionindex = 0;
                QuizCubit.score = 0;
                QuizCubit.currentanswer = null;
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

              fixedSize: WidgetStatePropertyAll(Size(double.maxFinite, 50)),
              shapecircularradius: 15,
            ),
            SizedBox(height: 10),
            CustomButton(
              icon: Icons.home,
              iconcolor: Colors.black,
              text: " Back to Home",
              backgroundColor: AppConsts.secondarycolor,
              textColor: Colors.black,
              onPressed: () {
                QuizCubit.questionindex = 0;
                QuizCubit.score = 0;
                QuizCubit.currentanswer = null;
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return HomeScreen();
                    },
                  ),
                  (route) => false,
                );
              },

              fixedSize: WidgetStatePropertyAll(Size(double.maxFinite, 50)),
              shapecircularradius: 15,
            ),
          ],
        ),
      ),
    );
  }
}
