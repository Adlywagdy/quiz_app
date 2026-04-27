// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Quiz App';

  @override
  String get startQuiz => 'Start Quiz';

  @override
  String get addQuestion => 'Add Question';

  @override
  String get question => 'Question';

  @override
  String get score => 'Score';

  @override
  String get next => 'Next';

  @override
  String get finish => 'Finish';
}
