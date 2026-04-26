import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/features/quiz_feature/data/quiz_firestore_service.dart';
import 'package:quiz_app/features/quiz_feature/models/questionmodel.dart';

part 'quiz_state.dart';

class QuizCubit extends Cubit<QuizStates> {
  QuizCubit({QuizFirestoreService? quizFirestoreService})
    : _quizFirestoreService = quizFirestoreService ?? QuizFirestoreService(),
      super(QuizInitialstate()) {
    loadQuestions();
  }

  final QuizFirestoreService _quizFirestoreService;

  static int questionindex = 0;
  static int score = 0;
  static String? currentanswer;
  static String? previousanswer;
  static List<QuestionModel> questions = [];

  static List<QuestionModel> failedquestions = [];

  static void resetQuizProgress() {
    questionindex = 0;
    score = 0;
    currentanswer = null;
    previousanswer = null;
    failedquestions = [];
  }

  Future<void> loadQuestions() async {
    try {
      emit(QuizLoadingstate());
      resetQuizProgress();
      questions = await _quizFirestoreService.getQuestions();

      if (questions.isEmpty) {
        emit(QuizEmptystate());
        return;
      }

      emit(Quizsucessstate());
    } catch (e) {
      emit(QuizFailedstate());
    }
  }

  Future<bool> addQuestionToFirebase({
    required String question,
    required List<String> options,
    required String answer,
  }) async {
    try {
      emit(QuizLoadingstate());
      await _quizFirestoreService.addQuestion(
        question: question,
        options: options,
        answer: answer,
      );
      await loadQuestions();
      return true;
    } catch (e) {
      emit(QuizFailedstate());
      return false;
    }
  }

  void nextquestionfun({required String useranswer}) {
    try {
      if (questions.isEmpty) {
        emit(QuizEmptystate());
        return;
      }

      emit(QuizLoadingstate());
      if (useranswer == questions[questionindex].answer) {
        score++;
      } else {
        failedquestions.add(questions[questionindex]);
      }

      if (questionindex < questions.length - 1) {
        questionindex++;
      }
      emit(Quizsucessstate());
    } catch (e) {
      emit(QuizFailedstate());
    }
  }

  void skipquestionfun() {
    try {
      if (questions.isEmpty) {
        emit(QuizEmptystate());
        return;
      }

      emit(QuizLoadingstate());
      failedquestions.add(questions[questionindex]);
      if (questionindex < questions.length - 1) {
        questionindex++;
      }
      emit(Quizsucessstate());
      QuizCubit.currentanswer = null;
    } catch (e) {
      emit(QuizFailedstate());
    }
  }

  void previousquestionfun() {
    try {
      if (questions.isEmpty || questionindex == 0) {
        emit(Quizsucessstate());
        return;
      }

      emit(QuizLoadingstate());

      questionindex--;
      if (failedquestions.length > questionindex) {
        failedquestions.removeAt(questionindex);
      }

      if (previousanswer == questions[questionindex].answer) {
        score--;
      }

      emit(Quizsucessstate());
    } catch (e) {
      emit(QuizFailedstate());
    }
  }

  void answersselectfun({required int index}) {
    try {
      if (questions.isEmpty) {
        emit(QuizEmptystate());
        return;
      }

      QuizCubit.currentanswer =
          QuizCubit.questions[QuizCubit.questionindex].options[index];
      emit(Quizsucessstate());
    } catch (e) {
      emit(QuizFailedstate());
    }
  }
}
