import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/features/quiz_feature/models/questionmodel.dart';

part 'quiz_state.dart';

class QuizCubit extends Cubit<QuizStates> {
  QuizCubit() : super(QuizInitialstate());
  static int questionindex = 0;
  static int score = 0;
  static String? currentanswer;
  static String? previousanswer;
  static List<QuestionModel> questions = [
    QuestionModel(
      question: "What is the capital of France?",
      options: ["Paris", "London", "Berlin", "Madrid"],
      answer: "Paris",
    ),
    QuestionModel(
      question: "Who painted the Mona Lisa?",
      options: [
        "Leonardo da Vinci",
        "Pablo Picasso",
        "Vincent van Gogh",
        "Claude Monet",
      ],
      answer: "Leonardo da Vinci",
    ),
    QuestionModel(
      question: "What is the largest planet in our solar system?",
      options: ["Earth", "Mars", "Jupiter", "Saturn"],
      answer: "Jupiter",
    ),
    QuestionModel(
      question: "What is the chemical symbol for water?",
      options: ["H2O", "CO2", "NaCl", "O2"],
      answer: "H2O",
    ),
    QuestionModel(
      question: "What is the highest mountain in the world?",
      options: ["Mount Everest", "K2", "Kangchenjunga", "Lhotse"],
      answer: "Mount Everest",
    ),
    QuestionModel(
      question: "What is the largest ocean on Earth?",
      options: [
        "Pacific Ocean",
        "Atlantic Ocean",
        "Indian Ocean",
        "Arctic Ocean",
      ],
      answer: "Pacific Ocean",
    ),
    QuestionModel(
      question: "Who wrote 'To Kill a Mockingbird'?",
      options: [
        "Harper Lee",
        "F. Scott Fitzgerald",
        "Jane Austen",
        "Emily Bronte",
      ],
      answer: "Harper Lee",
    ),
    QuestionModel(
      question: "What is the capital city of Egypt?",
      options: ["Cairo", "Alexandria", "Giza", "Luxor"],
      answer: "Cairo",
    ),
    QuestionModel(
      question: "What is the capital city of USA?",
      options: ["Washington D.C.", "New York", "Los Angeles", "Chicago"],
      answer: "Washington D.C.",
    ),
    QuestionModel(
      question: "What is the capital city of England?",
      options: ["London", "Manchester", "Birmingham", "Liverpool"],
      answer: "London",
    ),
  ];

  static List<QuestionModel> failedquestions = [];
  void nextquestionfun({required String useranswer}) {
    try {
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
      emit(QuizLoadingstate());

      questionindex--;
      failedquestions.removeAt(questionindex);

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
      QuizCubit.currentanswer =
          QuizCubit.questions[QuizCubit.questionindex].options[index];
      emit(Quizsucessstate());
    } catch (e) {
      emit(QuizFailedstate());
    }
  }
}
