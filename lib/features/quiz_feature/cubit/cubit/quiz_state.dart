part of 'quiz_cubit.dart';

abstract class QuizStates {}

final class QuizInitialstate extends QuizStates {}

final class Quizsucessstate extends QuizStates {}

final class QuizFailedstate extends QuizStates {}

final class QuizLoadingstate extends QuizStates {}

final class QuizEmptystate extends QuizStates {}
