# quiz_app

Flutter quiz app integrated with Firebase and Cloud Firestore.

## Firestore Collection Structure

Collection: `questions`

Each document contains:

- `question` (String)
- `options` (List<String>)
- `answer` (String)
- `createdAt` (Timestamp)

## Add Question Function

The function used to add a new question is:

- `QuizCubit.addQuestionToFirebase(...)`

Example:

```dart
context.read<QuizCubit>().addQuestionToFirebase(
	question: 'What is Flutter?',
	options: ['SDK', 'Database', 'IDE', 'Browser'],
	answer: 'SDK',
);
```

## Notes

- Firebase is initialized in `main.dart`.
- Questions are loaded from Firestore on app startup.
- If Firestore is empty, default seed questions are inserted once.
