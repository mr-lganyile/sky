import '/models/languages/language.dart';

class English extends Language {
  @override
  String translateAnswerOneQuestionOnly() {
    return 'Answer 1 Question By Text, Image Or Video.';
  }

  @override
  String translateImageAsAnswer() {
    return 'Answer With Image';
  }

  @override
  String translateImageMax10MB() {
    return 'Max 10MB';
  }

  @override
  String translateNoSwearing() {
    return 'No Swearing';
  }

  @override
  String translateTextAsAnswer() {
    return 'Answer With Text';
  }

  @override
  String translateVideoAsAnswer() {
    return 'Answer With Video';
  }

  @override
  String translateVideoMaxSeconds() {
    return 'Max 30 Seconds';
  }

  @override
  String translateWhatHappened() {
    return 'What Happened?';
  }

  @override
  String translateWhereWasIDrinking() {
    return 'Where Was I Drinking?';
  }

  @override
  String translateWhereWereYouDrinking() {
    return 'Where Were You Drinking?';
  }

  @override
  String translateWhoWasDrinkingWithMe() {
    return 'Who Was Drinking With Me?';
  }

  @override
  String translateWhoWereYouDrinkingWith() {
    return 'Who Were You Drinking With?';
  }

  @override
  String translateWhatWereYouDrinking() {
    return 'What Were You Drinking?';
  }

  @override
  String translateWhatWasIDrinking() {
    return 'What Was I Drinking?';
  }
}
