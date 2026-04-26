import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_app/features/quiz_feature/models/questionmodel.dart';

class QuizFirestoreService {
  QuizFirestoreService({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _questionsCollection =>
      _firestore.collection('questions');

  Future<List<QuestionModel>> getQuestions() async {
    final snapshot = await _questionsCollection.orderBy('createdAt').get();

    return snapshot.docs
        .map((doc) => QuestionModel.fromMap(doc.data(), id: doc.id))
        .where(
          (question) =>
              question.question.isNotEmpty &&
              question.options.isNotEmpty &&
              question.answer.isNotEmpty,
        )
        .toList();
  }

  Future<void> addQuestion({
    required String question,
    required List<String> options,
    required String answer,
  }) async {
    if (question.trim().isEmpty) {
      throw Exception('Question text cannot be empty.');
    }
    if (options.length < 2) {
      throw Exception('Question must contain at least two options.');
    }
    if (!options.contains(answer)) {
      throw Exception('Answer must be one of the options.');
    }

    final model = QuestionModel(
      question: question.trim(),
      options: options.map((item) => item.trim()).toList(),
      answer: answer.trim(),
    );

    await _questionsCollection.add({
      ...model.toMap(),
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}
