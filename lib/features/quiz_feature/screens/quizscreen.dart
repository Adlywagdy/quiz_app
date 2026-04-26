import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/core/consts.dart';
import 'package:quiz_app/features/quiz_feature/cubit/cubit/quiz_cubit.dart';
import 'package:quiz_app/features/quiz_feature/screens/quizresult.dart';

import 'package:quiz_app/features/quiz_feature/widgets/customanswersitem.dart';
import 'package:quiz_app/features/quiz_feature/widgets/custombutton.dart';
import 'package:quiz_app/features/quiz_feature/widgets/customlinearprogressindicator.dart';

class Quizscreen extends StatelessWidget {
  const Quizscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz', style: TextStyle(fontWeight: .w500)),
        centerTitle: true,
      ),
      body: BlocBuilder<QuizCubit, QuizStates>(
        builder: (context, state) {
          if (state is QuizLoadingstate && QuizCubit.questions.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }

          if (QuizCubit.questions.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('No questions found.'),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      context.read<QuizCubit>().loadQuestions();
                    },
                    child: Text('Reload'),
                  ),
                ],
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(14.0),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: CustomLinearProgressIndicator()),
                SliverToBoxAdapter(child: SizedBox(height: 20)),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Text(
                        QuizCubit.questions[QuizCubit.questionindex].question,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
                SliverList.builder(
                  itemCount: QuizCubit
                      .questions[QuizCubit.questionindex]
                      .options
                      .length,
                  itemBuilder: (context, index) {
                    return CustomAnswersItem(
                      questionsindex: QuizCubit.questionindex,
                      answersindex: index,
                      onTap: () {
                        BlocProvider.of<QuizCubit>(
                          context,
                        ).answersselectfun(index: index);
                      },
                      selected:
                          (QuizCubit
                                  .questions[QuizCubit.questionindex]
                                  .options[index] ==
                              QuizCubit.currentanswer)
                          ? true
                          : false,
                    );
                  },
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    mainAxisAlignment: .end,
                    children: [
                      CustomButton(
                        text: "Next  ->",
                        backgroundColor: AppConsts.primarycolor,
                        textColor: AppConsts.secondarycolor,
                        onPressed: () {
                          if (QuizCubit.currentanswer == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("please select an answer"),
                              ),
                            );
                          } else {
                            QuizCubit.previousanswer = QuizCubit.currentanswer!;
                            if (QuizCubit.questionindex >=
                                QuizCubit.questions.length - 1) {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return QuizResult(
                                      ispassed:
                                          QuizCubit.score >
                                              (QuizCubit.questions.length / 2)
                                          ? true
                                          : false,
                                    );
                                  },
                                ),
                                (route) => false,
                              );
                            } else {
                              BlocProvider.of<QuizCubit>(
                                context,
                              ).nextquestionfun(
                                useranswer: QuizCubit.currentanswer!,
                              );
                              QuizCubit.currentanswer = null;
                            }
                          }
                        },

                        fixedSize: WidgetStatePropertyAll(
                          Size(double.maxFinite, 50),
                        ),
                        shapecircularradius: 15,
                      ),
                      SizedBox(height: 10),
                      QuizCubit.questionindex > 0
                          ? CustomButton(
                              text: "back  <-",
                              backgroundColor: AppConsts.primarycolor,
                              textColor: AppConsts.secondarycolor,
                              onPressed: () {
                                BlocProvider.of<QuizCubit>(
                                  context,
                                ).previousquestionfun();
                              },

                              fixedSize: WidgetStatePropertyAll(
                                Size(double.maxFinite, 50),
                              ),
                              shapecircularradius: 15,
                            )
                          : SizedBox(height: 5),
                      TextButton(
                        onPressed: () {
                          if (QuizCubit.questionindex >=
                              QuizCubit.questions.length - 1) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return QuizResult(
                                    ispassed:
                                        QuizCubit.score >
                                            (QuizCubit.questions.length / 2)
                                        ? true
                                        : false,
                                  );
                                },
                              ),
                              (route) => false,
                            );
                          } else {
                            BlocProvider.of<QuizCubit>(
                              context,
                            ).skipquestionfun();
                          }
                          QuizCubit.currentanswer = null;
                        },
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
          );
        },
      ),
    );
  }
}
