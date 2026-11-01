import 'language.dart';

class Zulu extends Language {
  Zulu();

  @override
  String translateImageAsAnswer() {
    return 'Impendulo Eyisithombe';
  }

  @override
  String translateImageMax10MB() {
    return 'Singadluli Ku-10MB';
  }

  @override
  String translateNoSwearing() {
    return 'Akuthukwa Inhlamba';
  }

  @override
  String translateAnswerOneQuestionOnly() {
    return 'Phendula Umbuzo Owodwa Kuphela.';
  }

  @override
  String translateTextAsAnswer() {
    return 'Impendulo Ewumbhalo';
  }

  @override
  String translateVideoAsAnswer() {
    return 'Impendulo Eyi-Video';
  }

  @override
  String translateVideoMaxSeconds() {
    return 'Ingadluli Ku-30 Seconds';
  }

  @override
  String translateWhatHappened() {
    return 'Kwenzakaleni?';
  }

  @override
  String translateWhereWereYouDrinking() {
    return 'Ubuphuza Kephi?';
  }

  @override
  String translateWhoWereYouDrinkingWith() {
    return 'Ubuphuza Nobani?';
  }

  @override
  String translateWhereWasIDrinking() {
    return 'Bengiphuza Kuphi?';
  }

  @override
  String translateWhoWasDrinkingWithMe() {
    return 'Bengiphuza Nobani?';
  }

  @override
  String translateWhatWereYouDrinking() {
    return 'Ubuphuzani?';
  }

  @override
  String translateWhatWasIDrinking() {
    return 'Bengiphuzani?';
  }
}
