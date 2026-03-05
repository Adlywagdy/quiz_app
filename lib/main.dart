import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/core/consts.dart';
import 'package:quiz_app/features/quiz_feature/cubit/cubit/quiz_cubit.dart';
import 'package:quiz_app/features/quiz_feature/screens/homescreen.dart';

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuizCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        theme: ThemeData(
          primarySwatch: AppConsts.primarycolor,
          appBarTheme: AppBarTheme(backgroundColor: AppConsts.secondarycolor),
          scaffoldBackgroundColor: AppConsts.secondarycolor,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
