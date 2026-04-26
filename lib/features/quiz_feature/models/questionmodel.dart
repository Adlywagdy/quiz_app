class QuestionModel {
  final String? id;
  final String question;
  final List<String> options;
  final String answer;

  QuestionModel({
    this.id,
    required this.question,
    required this.options,
    required this.answer,
  });

  Map<String, dynamic> toMap() {
    return {'question': question, 'options': options, 'answer': answer};
  }

  factory QuestionModel.fromMap(Map<String, dynamic> map, {String? id}) {
    return QuestionModel(
      id: id,
      question: map['question'] as String? ?? '',
      options: List<String>.from(
        (map['options'] as List<dynamic>? ?? <dynamic>[]),
      ),
      answer: map['answer'] as String? ?? '',
    );
  }
}
