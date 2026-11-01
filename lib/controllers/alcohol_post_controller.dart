// ignore_for_file: prefer_final_fields

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sky/models/locations/supported_area.dart';

import 'dart:developer' as debug;

import '../models/converter.dart';
import '../models/locations/section_name.dart';
import '../models/locations/town_or_institution.dart';
import '../models/posts/alcohol_post.dart';
import '../models/posts/post_comment.dart';
import '../models/users/user.dart' as my;
import '../models/users/abstract_user.dart';
import '../screens/utils/globals.dart';

import 'user_controller.dart';

enum AlcoholPostStatus { loginRequired, answerAtleastOneQuestion, postSaved }

class AlcoholPostController extends GetxController {
  FirebaseFirestore firestore;
  FirebaseFunctions functions;
  Reference storage;
  FirebaseAuth auth;

  AlcoholPostController({
    required this.firestore,
    required this.storage,
    required this.functions,
    required this.auth,
  });

  static AlcoholPostController alcoholPostController = Get.find();
  UserController userController = UserController.userController;

  Rx<int> _recordersSeconds = Rx(DateTime.now().millisecondsSinceEpoch);
  int get recordersSeconds => _recordersSeconds.value;

  Rx<DateTime?> _dateCreated = Rx(null);
  DateTime? get dateCreated => _dateCreated.value;

  Rx<DocumentReference?> _alcoholPostReference = Rx(null);
  DocumentReference? get alcoholPostReference => _alcoholPostReference.value;

  // ======================Where Were You? [Start]======================
  Rx<String> _whereWereYouText = Rx('');
  String get whereWereYouText => _whereWereYouText.value;

  Rx<String> _whereWereYouImageURL = Rx('');
  String get whereWereYouImageURL => _whereWereYouImageURL.value;

  Rx<File?> _whereWereYouImage = Rx(null);
  File? get whereWereYouImage => _whereWereYouImage.value;

  Rx<String> _whereWereYouVoiceRecordURL = Rx('');
  String get whereWereYouVoiceRecordURL => _whereWereYouVoiceRecordURL.value;

  Rx<File?> _whereWereYouVoiceRecord = Rx(null);
  File? get whereWereYouVoiceRecord => _whereWereYouVoiceRecord.value;

  Rx<String> _whereWereYouVideoURL = Rx('');
  String get whereWereYouVideoURL => _whereWereYouVideoURL.value;

  Rx<File?> _whereWereYouVideo = Rx(null);
  File? get whereWereYouVideo => _whereWereYouVideo.value;

  String? host;

  // ======================Where Were You? [End]======================

  // ======================Who Were You With? [Start]======================
  // ignore: unused_field
  Rx<String> _whoWereYouWithText = Rx('');
  String get whoWereYouWithText => _whoWereYouWithText.value;

  // ignore: unused_field
  Rx<String> _whoWereYouWithImageURL = Rx('');
  String get whoWereYouWithImageURL => _whoWereYouWithImageURL.value;

  // ignore: unused_field
  Rx<File?> _whoWereYouWithImage = Rx(null);
  File? get whoWereYouWithImage => _whoWereYouWithImage.value;

  // ignore: unused_field
  Rx<String> _whoWereYouWithVoiceRecordURL = Rx('');
  String get whoWereYouWithVoiceRecordURL =>
      _whoWereYouWithVoiceRecordURL.value;

  // ignore: unused_field
  Rx<File?> _whoWereYouWithVoiceRecord = Rx(null);
  File? get whoWereYouWithVoiceRecord => _whoWereYouWithVoiceRecord.value;

  // ignore: unused_field
  Rx<String> _whoWereYouWithVideoURL = Rx('');
  String get whoWereYouWithVideoURL => _whoWereYouWithVideoURL.value;

  // ignore: unused_field
  Rx<File?> _whoWereYouWithVideo = Rx(null);
  File? get whoWereYouWithVideo => _whoWereYouWithVideo.value;

  // ======================Who Were You With? [End]======================

  // ======================What happended? [Start]======================

  // ignore: unused_field
  Rx<String> _whatHappenedText = Rx('');
  String get whatHappenedText => _whatHappenedText.value;

  // ignore: unused_field
  Rx<String> _whatHappenedVoiceRecordURL = Rx('');
  String get whatHappenedVoiceRecordURL => _whatHappenedVoiceRecordURL.value;

  // ignore: unused_field
  Rx<File?> _whatHappenedVoiceRecord = Rx(null);
  File? get whatHappenedVoiceRecord => _whatHappenedVoiceRecord.value;

  // ignore: unused_field
  Rx<String> _whatHappenedVideoURL = Rx('');
  String get whatHappenedVideoURL => _whatHappenedVideoURL.value;

  // ignore: unused_field
  Rx<File?> _whatHappenedVideo = Rx(null);
  File? get whatHappenedVideo => _whatHappenedVideo.value;

  // ======================What happended? [End]======================

  // ======================What Were You Drinking? [Start]======================
  // ignore: unused_field
  Rx<String> _whatWereYouDrinkingText = Rx('');
  String get whatWereYouDrinkingText => _whatWereYouDrinkingText.value;

  // ignore: unused_field
  Rx<String> _whatWereYouDrinkingImageURL = Rx('');
  String get whatWereYouDrinkingImageURL => _whatWereYouDrinkingImageURL.value;

  // ignore: unused_field
  Rx<File?> _whatWereYouDrinkingImage = Rx(null);
  File? get whatWereYouDrinkingImage => _whatWereYouDrinkingImage.value;
  // ======================What Were You Drinking? [End]======================

  void setRecordersSeconds() {
    _recordersSeconds = Rx(DateTime.now().second);
  }

  void setWhereWereYouText(String whereWereYouText) {
    _whereWereYouText = Rx(whereWereYouText);
    update();
  }

  void clearForWhereWereYouText() {
    _whereWereYouImage = Rx(null);
    _whereWereYouImageURL = Rx('');
    _whereWereYouVoiceRecord = Rx(null);
    _whereWereYouVoiceRecordURL = Rx('');
    _whereWereYouVideo = Rx(null);
    _whereWereYouVideoURL = Rx('');
    update();
  }

  void clearForWhereWereYouImage() {
    _whereWereYouText = Rx('');
    _whereWereYouVoiceRecord = Rx(null);
    _whereWereYouVoiceRecordURL = Rx('');
    _whereWereYouVideo = Rx(null);
    _whereWereYouVideoURL = Rx('');
    update();
  }

  void clearForWhereWereYouVoiceRecord() {
    _whereWereYouText = Rx('');
    _whereWereYouImage = Rx(null);
    _whereWereYouImageURL = Rx('');
    _whereWereYouVideo = Rx(null);
    _whereWereYouVideoURL = Rx('');
    update();
  }

  void clearForWhereWereYouVideo() {
    _whereWereYouText = Rx('');
    _whereWereYouImage = Rx(null);
    _whereWereYouImageURL = Rx('');
    _whereWereYouVoiceRecord = Rx(null);
    _whereWereYouVoiceRecordURL = Rx('');
    update();
  }

  void captureWhereWereYouImage() async {
    AbstractUser? user = getCurrentlyLoggenInUser();
    if (user == null) {
      Get.snackbar('Error', 'Error Login Required');
    } else {
      final pickedImageFile = await ImagePicker().pickImage(
        source: ImageSource.camera,
      );

      if (pickedImageFile != null) {
        _whereWereYouImage = Rx<File?>(File(pickedImageFile.path));

        my.User alcoholic = user as my.User;
        host = Converter.townOrInstitutionAsString(
          Converter.toSupportedTownOrInstitution(
            alcoholic.area.sectionName,
          ).townOrInstitutionName,
        ).toLowerCase();

        setAlcoholPostReference();

        _whereWereYouImageURL = Rx<String>(
          await uploadResource(
            _whereWereYouImage.value!,
            '$host/alcohol_posts/where_were_you/images/${_alcoholPostReference.value!.id}',
          ),
        );

        // Get.snackbar('Image Status', 'Image File Successfully Captured.');
        update();
      } else {
        Get.snackbar('Error', 'Image Wasn\'t Captured.');
      }
    }
  }

  void captureWhereWereYouVideo(ImageSource imageSource) async {
    AbstractUser? user = getCurrentlyLoggenInUser();
    if (user == null) {
      Get.snackbar('Error', 'Error Login Required');
    }

    final pickedVideoFile = await ImagePicker().pickVideo(source: imageSource);

    if (pickedVideoFile != null) {
      File file = File(pickedVideoFile.path);
      _whereWereYouVideo = Rx<File?>(file);

      my.User alcoholic = user as my.User;
      host = Converter.townOrInstitutionAsString(
        Converter.toSupportedTownOrInstitution(
          alcoholic.area.sectionName,
        ).townOrInstitutionName,
      ).toLowerCase();

      setAlcoholPostReference();

      _whereWereYouVideoURL = Rx<String>(
        await uploadResource(
          _whereWereYouVideo.value!,
          '$host/alcohol_posts/where_were_you/videos/${_alcoholPostReference.value!.id}',
          contentType: "video/mp4",
        ),
      );

      debug.log('Video File Successfully Captured');
      debug.log('Created AT ${_whereWereYouVideoURL.value}');
      //Get.snackbar('Video Status', 'Video File Successfully Captured.');
      update();
    } else {
      Get.snackbar('Error', 'Video Wasn\'t Captured.');
    }
  }

  // ======================Where Were You? [End]======================

  // ======================Who Were You With? [Start]======================

  void setWhoWereYouWithText(String whoWereYouWithText) {
    _whoWereYouWithText = Rx(whoWereYouWithText);
    update();
  }

  void clearForWhoWereYouWithText() {
    _whoWereYouWithImage = Rx(null);
    _whoWereYouWithImageURL = Rx('');
    _whoWereYouWithVoiceRecord = Rx(null);
    _whoWereYouWithVoiceRecordURL = Rx('');
    _whoWereYouWithVideo = Rx(null);
    _whoWereYouWithVideoURL = Rx('');
    update();
  }

  void clearForWhoWereYouWithImage() {
    _whoWereYouWithText = Rx('');
    _whoWereYouWithVoiceRecord = Rx(null);
    _whoWereYouWithVoiceRecordURL = Rx('');
    _whoWereYouWithVideo = Rx(null);
    _whoWereYouWithVideoURL = Rx('');
    update();
  }

  void clearForWhoWereYouWithVoiceRecord() {
    _whoWereYouWithText = Rx('');
    _whoWereYouWithImage = Rx(null);
    _whoWereYouWithImageURL = Rx('');
    _whoWereYouWithVideo = Rx(null);
    _whoWereYouWithVideoURL = Rx('');
    update();
  }

  void clearForWhoWereYouWithVideo() {
    _whoWereYouWithText = Rx('');
    _whoWereYouWithImage = Rx(null);
    _whoWereYouWithImageURL = Rx('');
    _whoWereYouWithVoiceRecord = Rx(null);
    _whoWereYouWithVoiceRecordURL = Rx('');
    update();
  }

  void captureWhoWereYouWithImage() async {
    AbstractUser? user = getCurrentlyLoggenInUser();
    if (user == null) {
      Get.snackbar('Error', 'Error Login Required');
    } else {
      final pickedImageFile = await ImagePicker().pickImage(
        source: ImageSource.camera,
      );

      if (pickedImageFile != null) {
        _whoWereYouWithImage = Rx<File?>(File(pickedImageFile.path));

        my.User alcoholic = user as my.User;
        host = Converter.townOrInstitutionAsString(
          Converter.toSupportedTownOrInstitution(
            alcoholic.area.sectionName,
          ).townOrInstitutionName,
        ).toLowerCase();

        setAlcoholPostReference();

        _whoWereYouWithImageURL = Rx<String>(
          await uploadResource(
            _whoWereYouWithImage.value!,
            '$host/alcohol_posts/who_were_you_with/images/${_alcoholPostReference.value!.id}',
          ),
        );

        // Get.snackbar('Image Status', 'Image File Successfully Captured.');
        update();
      } else {
        Get.snackbar('Error', 'Image Wasn\'t Captured.');
      }
    }
  }

  void captureWhoWereYouWithVideo(ImageSource imageSource) async {
    AbstractUser? user = getCurrentlyLoggenInUser();
    if (user == null) {
      Get.snackbar('Error', 'Error Login Required');
    }

    final pickedVideoFile = await ImagePicker().pickVideo(source: imageSource);

    if (pickedVideoFile != null) {
      File file = File(pickedVideoFile.path);
      _whoWereYouWithVideo = Rx<File?>(file);

      my.User alcoholic = user as my.User;
      host = Converter.townOrInstitutionAsString(
        Converter.toSupportedTownOrInstitution(
          alcoholic.area.sectionName,
        ).townOrInstitutionName,
      ).toLowerCase();

      setAlcoholPostReference();

      _whoWereYouWithVideoURL = Rx<String>(
        await uploadResource(
          _whoWereYouWithVideo.value!,
          '$host/alcohol_posts/who_were_you_with/videos/${_alcoholPostReference.value!.id}',
          contentType: 'video/mp4',
        ),
      );

      // Get.snackbar('Video Status', 'Video File Successfully Picked.');
      update();
    } else {
      Get.snackbar('Error', 'Video Wasn\'t Picked.');
    }
  }

  // ======================Who Were You With? [End]======================

  // ======================What happended? [Start]======================

  void setWhatHappedText(String whatHappenedText) {
    _whatHappenedText = Rx(whatHappenedText);
    update();
  }

  void clearForWhatHappenedText() {
    _whatHappenedVoiceRecord = Rx(null);
    _whatHappenedVoiceRecordURL = Rx('');
    _whatHappenedVideo = Rx(null);
    _whatHappenedVideoURL = Rx('');
    update();
  }

  void clearForWhatHappenedVoiceRecord() {
    _whatHappenedText = Rx('');
    _whatHappenedVideo = Rx(null);
    _whatHappenedVideoURL = Rx('');
    update();
  }

  void clearForWhatHappenedVideo() {
    _whatHappenedText = Rx('');
    _whatHappenedVoiceRecord = Rx(null);
    _whatHappenedVoiceRecordURL = Rx('');
    update();
  }

  void captureWhatHappenedVideo(ImageSource imageSource) async {
    AbstractUser? user = getCurrentlyLoggenInUser();
    if (user == null) {
      Get.snackbar('Error', 'Error Login Required');
    }

    final pickedVideoFile = await ImagePicker().pickVideo(source: imageSource);

    if (pickedVideoFile != null) {
      File file = File(pickedVideoFile.path);
      _whatHappenedVideo = Rx<File?>(file);

      my.User alcoholic = user as my.User;
      host = Converter.townOrInstitutionAsString(
        Converter.toSupportedTownOrInstitution(
          alcoholic.area.sectionName,
        ).townOrInstitutionName,
      ).toLowerCase();

      setAlcoholPostReference();

      _whatHappenedVideoURL = Rx<String>(
        await uploadResource(
          _whatHappenedVideo.value!,
          '$host/alcohol_posts/what_happened/videos/${_alcoholPostReference.value!.id}',
          contentType: 'video/mp4',
        ),
      );

      update();
    } else {
      Get.snackbar('Error', 'Video Wasn\'t Captured.');
    }
  }
  // ======================What happended? [End]======================

  // ======================What Were You Drinking? [Start]======================
  void setWhatWereYouDrinkingText(String whatWereYouDrinkingText) {
    _whatWereYouDrinkingText = Rx(whatWereYouDrinkingText);
    update();
  }

  void clearForWhatWereYouDrinkingText() {
    _whatWereYouDrinkingImage = Rx(null);
    _whatWereYouDrinkingImageURL = Rx('');
    update();
  }

  void clearForWhatWereYouDrinkingImage() {
    _whatWereYouDrinkingText = Rx('');
    update();
  }

  void captureWhatWereYouDrinkingImage() async {
    AbstractUser? user = getCurrentlyLoggenInUser();
    if (user == null) {
      Get.snackbar('Error', 'Error Login Required');
    } else {
      final pickedImageFile = await ImagePicker().pickImage(
        source: ImageSource.camera,
      );

      if (pickedImageFile != null) {
        _whatWereYouDrinkingImage = Rx<File?>(File(pickedImageFile.path));

        my.User alcoholic = user as my.User;
        host = Converter.townOrInstitutionAsString(
          Converter.toSupportedTownOrInstitution(
            alcoholic.area.sectionName,
          ).townOrInstitutionName,
        ).toLowerCase();

        setAlcoholPostReference();

        _whatWereYouDrinkingImageURL = Rx<String>(
          await uploadResource(
            _whatWereYouDrinkingImage.value!,
            '$host/alcohol_posts/what_were_you_drinking/images/${_alcoholPostReference.value!.id}',
          ),
        );

        update();
      } else {
        Get.snackbar('Error', 'Image Wasn\'t Captured.');
      }
    }
  }
  // ======================What Were You Drinking? [End]======================

  void clear() {
    _whereWereYouText = Rx('');
    _whoWereYouWithText = Rx('');
    _whatHappenedText = Rx('');
    _whatWereYouDrinkingText = Rx('');

    _whereWereYouImageURL = Rx('');
    _whoWereYouWithImageURL = Rx('');
    _whatWereYouDrinkingImageURL = Rx('');

    _whereWereYouImage = Rx(null);
    _whoWereYouWithImage = Rx(null);
    _whatWereYouDrinkingImage = Rx(null);

    _whereWereYouVoiceRecordURL = Rx('');
    _whoWereYouWithVoiceRecordURL = Rx('');
    _whatHappenedVoiceRecordURL = Rx('');

    _whereWereYouVoiceRecord = Rx(null);
    _whoWereYouWithVoiceRecord = Rx(null);
    _whatHappenedVoiceRecord = Rx(null);

    _whereWereYouVideoURL = Rx('');
    _whoWereYouWithVideoURL = Rx('');
    _whatHappenedVideoURL = Rx('');

    _whereWereYouVideo = Rx(null);
    _whoWereYouWithVideo = Rx(null);
    _whatHappenedVideo = Rx(null);
  }

  void setDateCreated() {
    _dateCreated = Rx(DateTime.now());
    update();
  }

  void setAlcoholPostReference() {
    if (_alcoholPostReference.value == null) {
      _alcoholPostReference = Rx(firestore.collection('alcohol_posts').doc());
    }
  }

  void clearAlcoholPostReference() {
    if (_alcoholPostReference.value != null) {
      _alcoholPostReference = Rx(null);
    }
  }

  bool hasAnsweredQuestions() {
    // No text shared.
    if (whereWereYouText.isNotEmpty ||
        whoWereYouWithText.isNotEmpty ||
        whatHappenedText.isNotEmpty ||
        whatWereYouDrinkingText.isNotEmpty) {
      return true;
    }

    // No image shared.
    if ((whereWereYouImage != null && whereWereYouImageURL.isNotEmpty) ||
        (whoWereYouWithImage != null && whoWereYouWithImageURL.isNotEmpty) ||
        (whatWereYouDrinkingImage != null &&
            whatWereYouDrinkingImageURL.isNotEmpty)) {
      return true;
    }

    // No voice record shared.
    if (whereWereYouVoiceRecord != null ||
        whoWereYouWithVoiceRecord != null ||
        whatHappenedVoiceRecord != null) {
      return true;
    }

    // No video shared.
    if (whereWereYouVideo != null ||
        whoWereYouWithVideo != null ||
        whatHappenedVideo != null) {
      return true;
    }

    return false;
  }

  Stream<List<AlcoholPost>> readAllAlcoholPosts() =>
      firestore.collection('alcohol_posts').snapshots().map((postsSnapshot) {
        List<AlcoholPost> list = postsSnapshot.docs.map((postDoc) {
          AlcoholPost post = AlcoholPost.fromJson(postDoc.data());
          return post;
        }).toList();
        list.sort();
        return list;
      });

  Stream<List<AlcoholPost>>
  readAreaAlcoholPosts(String forTownOrInstitutionNo)
  /*=> Stream.value([
    AlcoholPost(
      postId: 'abc',
      forTownOrInstitutionNo: "7",
      dateCreated: DateTime.now(),
      postCreator: my.User(
        userId: 'user_abc',
        phoneNumber: '+27867546567',
        profileImageURL: '../images/image_abc.png',
        area: SupportedArea(
          townOrInstitutionFK: "7",
          sectionName:
              SectionName.bereaDurbanCentralDurbanKwaZuluNatalSouthAfrica,
          areaNo: "44",
        ),
        username: 'mr lganyile',
        password: 'nikhwe',
      ),
      whereWereYouText:
          '''kunamadoda amabili aflathelene, enye ibheke empumalanga, enye ibheke entshonalanga.
enye ibheke ekhaya bonina, enye ibheke ekhaya boyise. ''',
    ),
    AlcoholPost(
      postId: 'def',
      forTownOrInstitutionNo: "7",
      dateCreated: DateTime.now(),
      postCreator: my.User(
        userId: 'user_def',
        phoneNumber: '+27867599867',
        profileImageURL: '../images/image_def.png',
        area: SupportedArea(
          townOrInstitutionFK: "7",
          sectionName:
              SectionName.glenwoodDurbanCentralDurbanKwaZuluNatalSouthAfrica,
          areaNo: "43",
        ),
        username: 'londy',
        password: 'lpd',
      ),
      whoWereYouWithImageURL: '''../images/some_image.jpg''',
    ),
    AlcoholPost(
      postId: 'ghi',
      forTownOrInstitutionNo: "7",
      dateCreated: DateTime.now(),
      postCreator: my.User(
        userId: 'user_ghi',
        phoneNumber: '+27676599867',
        profileImageURL: '../images/image_ghi.png',
        area: SupportedArea(
          townOrInstitutionFK: "7",
          sectionName:
              SectionName.southBeachDurbanCentralDurbanKwaZuluNatalSouthAfrica,
          areaNo: "45",
        ),
        username: 'simphiwe',
        password: 'simp',
      ),
      whatHappenedVideoURL: '''../videos/some_video.jpg''',
    ),
  ]); */
  => firestore
      .collection('alcohol_posts')
      .where('forTownOrInstitutionNo', isEqualTo: forTownOrInstitutionNo)
      .snapshots()
      .map((postsSnapshot) {
        List<AlcoholPost> list = postsSnapshot.docs.map((postDoc) {
          AlcoholPost post = AlcoholPost.fromJson(postDoc.data());
          return post;
        }).toList();
        list.sort();
        return list;
      });

  Future<AlcoholPostStatus> saveAlcoholPost() async {
    AbstractUser? user = getCurrentlyLoggenInUser();

    if (user == null) {
      return AlcoholPostStatus.loginRequired;
    } else if (!hasAnsweredQuestions()) {
      return AlcoholPostStatus.answerAtleastOneQuestion;
    } else {
      if (whereWereYouText.isNotEmpty) {
        clearForWhereWereYouText();
      } else if (whereWereYouImageURL.isNotEmpty) {
        clearForWhereWereYouImage();
      } else if (whereWereYouVoiceRecordURL.isNotEmpty) {
        clearForWhereWereYouVoiceRecord();
      } else if (whereWereYouVideoURL.isNotEmpty) {
        clearForWhereWereYouVideo();
      }

      if (whoWereYouWithText.isNotEmpty) {
        clearForWhoWereYouWithText();
      } else if (whoWereYouWithImageURL.isNotEmpty) {
        clearForWhoWereYouWithImage();
      } else if (whoWereYouWithVoiceRecordURL.isNotEmpty) {
        clearForWhoWereYouWithVoiceRecord();
      } else if (whoWereYouWithVideoURL.isNotEmpty) {
        clearForWhoWereYouWithVideo();
      }

      if (whatHappenedText.isNotEmpty) {
        clearForWhatHappenedText();
      } else if (whatHappenedVoiceRecordURL.isNotEmpty) {
        clearForWhatHappenedVoiceRecord();
      } else if (whatHappenedVideoURL.isNotEmpty) {
        clearForWhatHappenedVideo();
      }

      if (whatWereYouDrinkingText.isNotEmpty) {
        clearForWhatWereYouDrinkingText();
      } else if (whatWereYouDrinkingImageURL.isNotEmpty) {
        clearForWhatWereYouDrinkingImage();
      }

      setAlcoholPostReference();

      if (host == null) {
        my.User? alcoholic = getCurrentlyLoggenInUser() as my.User;

        host = Converter.townOrInstitutionAsString(
          Converter.toSupportedTownOrInstitution(
            alcoholic.area.sectionName,
          ).townOrInstitutionName,
        ).toLowerCase();
      }

      // FieldValue.serverTimestamp();
      AlcoholPost post = AlcoholPost(
        postId: _alcoholPostReference.value!.id,
        postCreator: user as my.User,
        forTownOrInstitutionNo: user.area.townOrInstitutionFK,
        whereWereYouText: whereWereYouText,
        whereWereYouImageURL: trimmedURL(whereWereYouImageURL),
        whereWereYouVoiceRecordURL: trimmedURL(whereWereYouVoiceRecordURL),
        whereWereYouVideoURL: trimmedURL(whereWereYouVideoURL),
        whoWereYouWithText: whoWereYouWithText,
        whoWereYouWithImageURL: trimmedURL(whoWereYouWithImageURL),
        whoWereYouWithVoiceRecordURL: trimmedURL(whoWereYouWithVoiceRecordURL),
        whoWereYouWithVideoURL: trimmedURL(whoWereYouWithVideoURL),
        whatHappenedText: whatHappenedText,
        whatHappenedVoiceRecordURL: trimmedURL(whatHappenedVoiceRecordURL),
        whatHappenedVideoURL: trimmedURL(whatHappenedVideoURL),
        whatWereYouDrinkingText: whatWereYouDrinkingText,
        whatWereYouDrinkingImageURL: trimmedURL(whatWereYouDrinkingImageURL),
      );

      await _alcoholPostReference.value!.set(post.toJson());
      clearAlcoholPostReference();
      setRecordersSeconds();
      clear();
      return AlcoholPostStatus.postSaved;
    }
  }

  Future<void> saveAlcoholPostComment(String postFK, String message) async {
    AbstractUser? user = getCurrentlyLoggenInUser();

    if (user == null) {
      getSnapbar('Unauthorized Action', 'Login Before Commenting');
      return;
    }
    TownOrInstitution townOrInstitution;
    townOrInstitution = Converter.toSupportedTownOrInstitution(
      (user as my.User).area.sectionName,
    ).townOrInstitutionName;

    DocumentReference pastPostRef = firestore
        .collection('alcohol_posts')
        .doc(postFK);

    pastPostRef.get().then((pastPostDoc) async {
      if (pastPostDoc.exists) {
        AlcoholPost pastPost = AlcoholPost.fromJson(pastPostDoc.data());

        int one = int.parse(pastPost.postCreator.area.townOrInstitutionFK);
        int two = int.parse(
          userController.currentlyLoggedInUser!.area.townOrInstitutionFK,
        );
        bool result = one == two;

        if (result) {
          DocumentReference commentReference = pastPostRef
              .collection('comments')
              .doc();
          PostComment? comment;
          if (userController.currentlyLoggedInUser != null) {
            comment = PostComment(
              postCommentId: commentReference.id,
              forTownOrInstitution: townOrInstitution,
              postFK: postFK,
              message: message,
              imageURL: userController.currentlyLoggedInUser!.profileImageURL,
              username: userController.currentlyLoggedInUser!.username,
            );
          }

          await commentReference.set(comment!.toJson());
        } else {
          String host = Converter.townOrInstitutionAsString(
            Converter.toSupportedTownOrInstitution(
              pastPost.postCreator.area.sectionName,
            ).townOrInstitutionName,
          );
          ;
          Get.snackbar('Error', 'Only $host Users May Comment.');
        }
      }
    });
  }

  Stream<List<PostComment>> readAlcoholPostComments(String postFK) => firestore
      .collection('alcohol_posts')
      .doc(postFK)
      .collection('comments')
      .snapshots()
      .map((commentsSnapshot) {
        List<PostComment> list = commentsSnapshot.docs.map((commentDoc) {
          PostComment comment = PostComment.fromJson(commentDoc.data());
          return comment;
        }).toList();
        list.sort();
        return list;
      });
}
