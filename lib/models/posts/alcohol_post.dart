import '../users/user.dart' as my;
import 'post.dart';

class AlcoholPost extends Post implements Comparable<AlcoholPost> {
  String whereWereYouText;
  String whereWereYouImageURL;
  String whereWereYouVoiceRecordURL;
  String whereWereYouVideoURL;

  String whoWereYouWithText;
  String whoWereYouWithImageURL;
  String whoWereYouWithVoiceRecordURL;
  String whoWereYouWithVideoURL;

  String whatHappenedText;
  String whatHappenedVoiceRecordURL;
  String whatHappenedVideoURL;

  String? whatWereYouDrinkingText;
  String? whatWereYouDrinkingImageURL;

  AlcoholPost({
    required String postId,
    required my.User postCreator,
    DateTime? dateCreated,
    forTownOrInstitutionNo,
    this.whereWereYouImageURL = '',
    this.whereWereYouText = '',
    this.whereWereYouVoiceRecordURL = '',
    this.whereWereYouVideoURL = '',
    this.whoWereYouWithText = '',
    this.whoWereYouWithImageURL = '',
    this.whoWereYouWithVoiceRecordURL = '',
    this.whoWereYouWithVideoURL = '',
    this.whatHappenedText = '',
    this.whatHappenedVoiceRecordURL = '',
    this.whatHappenedVideoURL = '',
    this.whatWereYouDrinkingText,
    this.whatWereYouDrinkingImageURL,
  }) : super(
         postId: postId,
         postCreator: postCreator,
         dateCreated: dateCreated,
         forTownOrInstitutionNo: forTownOrInstitutionNo,
       );

  Map<String, dynamic> toJson() => {
    'postId': postId,
    'postCreator': postCreator.toJson(),
    'forTownOrInstitutionNo': forTownOrInstitutionNo,
    'whereWereYouText': whereWereYouText,
    'whereWereYouImageURL': whereWereYouImageURL,
    'whereWereYouVoiceRecordURL': whereWereYouVoiceRecordURL,
    'whereWereYouVideoURL': whereWereYouVideoURL,
    'whoWereYouWithText': whoWereYouWithText,
    'whoWereYouWithImageURL': whoWereYouWithImageURL,
    'whoWereYouWithVoiceRecordURL': whoWereYouWithVoiceRecordURL,
    'whoWereYouWithVideoURL': whoWereYouWithVideoURL,
    'whatHappenedText': whatHappenedText,
    'whatHappenedVoiceRecordURL': whatHappenedVoiceRecordURL,
    'whatHappenedVideoURL': whatHappenedVideoURL,
    'whatWereYouDrinkingText': whatWereYouDrinkingText,
    'whatWereYouDrinkingImageURL': whatWereYouDrinkingImageURL,
  };

  factory AlcoholPost.fromJson(dynamic json) => AlcoholPost(
    postId: json['postId'],
    postCreator: my.User.fromJson(json['postCreator']),
    dateCreated: DateTime(
      json['dateCreated']['year'],
      json['dateCreated']['month'],
      json['dateCreated']['date'],
      json['dateCreated']['hour'],
      json['dateCreated']['minute'],
    ),
    forTownOrInstitutionNo: json['forTownOrInstitutionNo'],
    whereWereYouText: json['whereWereYouText'],
    whereWereYouImageURL: json['whereWereYouImageURL'],
    whereWereYouVoiceRecordURL: json['whereWereYouVoiceRecordURL'],
    whereWereYouVideoURL: json['whereWereYouVideoURL'],
    whoWereYouWithText: json['whoWereYouWithText'],
    whoWereYouWithImageURL: json['whoWereYouWithImageURL'],
    whoWereYouWithVoiceRecordURL: json['whoWereYouWithVoiceRecordURL'],
    whoWereYouWithVideoURL: json['whoWereYouWithVideoURL'],
    whatHappenedText: json['whatHappenedText'],
    whatHappenedVoiceRecordURL: json['whatHappenedVoiceRecordURL'],
    whatHappenedVideoURL: json['whatHappenedVideoURL'],

    whatWereYouDrinkingText: json['whatWereYouDrinkingText'],
    whatWereYouDrinkingImageURL: json['whatWereYouDrinkingImageURL'],
  );

  bool hasWhereWereYouText() {
    return whereWereYouText.isNotEmpty;
  }

  bool hasWhereWereYouImage() {
    return whereWereYouImageURL.isNotEmpty;
  }

  bool hasWhereWereYouVoiceRecord() {
    return whereWereYouVoiceRecordURL.isNotEmpty;
  }

  bool hasWhereWereYouVideo() {
    return whereWereYouVideoURL.isNotEmpty;
  }

  bool hasWhoWereYouWithText() {
    return whoWereYouWithText.isNotEmpty;
  }

  bool hasWhoWereYouWithImage() {
    return whoWereYouWithImageURL.isNotEmpty;
  }

  bool hasWhoWereYouWithVoiceRecord() {
    return whoWereYouWithVoiceRecordURL.isNotEmpty;
  }

  bool hasWhoWereYouWithVideo() {
    return whoWereYouWithVideoURL.isNotEmpty;
  }

  bool hasWhatHappenedText() {
    return whatHappenedText.isNotEmpty;
  }

  bool hasWhatHappenedVoiceRecord() {
    return whatHappenedVoiceRecordURL.isNotEmpty;
  }

  bool hasWhatHappenedVideo() {
    return whatHappenedVideoURL.isNotEmpty;
  }

  bool hasWhatWereYouDrinkingText() {
    return whatWereYouDrinkingText != null &&
        whatWereYouDrinkingText!.isNotEmpty;
  }

  bool hasWhatWereYouDrinkingImage() {
    return whatWereYouDrinkingImageURL != null &&
        whatWereYouDrinkingImageURL!.isNotEmpty;
  }

  @override
  int compareTo(AlcoholPost other) {
    return other.dateCreated!.compareTo(dateCreated!);
  }
}
