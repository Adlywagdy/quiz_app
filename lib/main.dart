import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/core/consts.dart';
import 'package:quiz_app/firebase_options.dart';
import 'package:quiz_app/features/quiz_feature/cubit/cubit/quiz_cubit.dart';
import 'package:quiz_app/features/quiz_feature/screens/homescreen.dart';
import 'package:quiz_app/l10n/generated/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuizCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        locale: Locale('ar'),
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
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
