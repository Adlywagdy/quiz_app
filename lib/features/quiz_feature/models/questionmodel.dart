class QuestionModel {
  final String question;
  final List<String> options;
  final String answer;

  QuestionModel({
    required this.question,
    required this.options,
    required this.answer,
  });
}

List<QuestionModel> questions = [
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
