//import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/shared_resources_controller.dart';
import '../../controllers/user_controller.dart';
import '../../main.dart';
import 'dart:developer' as debug;
import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';

import '../../models/users/abstract_user.dart';

import '../../models/users/user.dart' as my;

final firestore = FirebaseFirestore.instance;
final functions = FirebaseFunctions.instance;
final auth = FirebaseAuth.instance;
final reference =
    FirebaseStorage
        //.instance.ref();
        .instanceFor(bucket: "gs://sky-4all.firebasestorage.app")
        .ref();

// for users but not admins (a bit complicated).
UserController userController = UserController.userController;

SharedResourcesController sharedResourcesController =
    SharedResourcesController.sharedResourcesController;

double listTileText1FontSize = 14;
double listTileText2FontSize = 14;

// Upload an image into a particular firebase storage bucket.
Future<String> uploadResource(
  File resource,
  String storagePath, {
  String contentType = "image/jpeg",
}) async {
  final metadata = SettableMetadata(contentType: contentType);

  UploadTask uploadTask;
  TaskSnapshot taskSnapshot;
  String downloadURL;

  if (contentType.contains('video')) {
    /*
    await VideoCompress.setLogLevel(0);
    // Return type of compressVideo Future<MediaInfo> or MediaInfo
    final info = await VideoCompress.compressVideo(
      file.path,
      quality: VideoQuality.MediumQuality,
      deleteOrigin: false,
      includeAudio: true,
    );
    print(info!.path);
    */
    uploadTask = reference.child(storagePath).putFile(resource, metadata);
    taskSnapshot = await uploadTask;

    downloadURL = await taskSnapshot.ref.getDownloadURL();
    return downloadURL;
  }

  return await compressImage(resource).then((compressedImageFile) async {
    if (compressedImageFile == null) {
      uploadTask = reference.child(storagePath).putFile(resource, metadata);
      taskSnapshot = await uploadTask;

      downloadURL = await taskSnapshot.ref.getDownloadURL();
      return downloadURL;
    } else {
      uploadTask = reference
          .child(storagePath)
          .putFile(compressedImageFile, metadata);
      taskSnapshot = await uploadTask;

      downloadURL = await taskSnapshot.ref.getDownloadURL();
      return downloadURL;
    }
  });
}

Future<File?> compressImage(File file) async {
  debug.log('Before Compression ${file.lengthSync() / 1024}kb');

  XFile? result = (await FlutterImageCompress.compressAndGetFile(
    file.absolute.path,
    '${file.path}.compressed.jpg',
    quality: 88,
    // rotate: 180,
  ));

  if (result == null) {
    debug.log('After Compression Result Is Null');
    return null;
  } else {
    result.length().then((value) {
      debug.log('Result Path [After Compression] ${result.path}');
    });

    return File(result.path);
  }
}

Future<String> findFullURL(String imageURL) async {
  return await reference.child(imageURL).getDownloadURL();
}

Widget displayImage(String imageURL) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: AspectRatio(
      aspectRatio: 2 / 3,
      child: FutureBuilder(
        future: findFullURL(imageURL),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return CachedNetworkImage(
              key: UniqueKey(),
              fit: BoxFit.cover,
              imageUrl: snapshot.data.toString(),
              fadeOutCurve: Curves.easeOutExpo,
              imageBuilder: (c, provider) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(fit: BoxFit.cover, image: provider),
                  ),
                );
              },
              placeholder: (c, s) {
                return getCircularProgressBar();
              },
              errorWidget: (c, s, d) {
                return getCircularProgressBar();
              },
            );
          } else if (snapshot.hasError) {
            debug.log(
              'Error Fetching Image from display image - ${snapshot.error}',
            );
            return getCircularProgressBar();
          } else {
            return getCircularProgressBar();
          }
        },
      ),
    ),
  );
}

Future<bool> isLoginAcceptable(String phoneNumber, String password) async {
  Query<Map<String, dynamic>> reference;
  reference = firestore.collection('users');
  reference.get().then((snapshot) {
    snapshot.docs.map((userDoc) {
      my.User user = my.User.fromJson(userDoc.data());

      if (user.phoneNumber.compareTo(phoneNumber) == 0 &&
          user.password.compareTo(password) == 0) {
        return true;
      }
    });
  });
  return false;
}

Future<AggregateQuerySnapshot> isCredentialsCorrect(
  String phoneNumber,
  String password,
  bool forAdmin,
) async {
  Query<Map<String, dynamic>> reference;
  reference = firestore
      .collection('users')
      .where("phoneNumber", isEqualTo: phoneNumber)
      .where('password', isEqualTo: password);

  AggregateQuerySnapshot? result = await reference.count().get();
  return result;
}

AbstractUser? getCurrentlyLoggenInUser() {
  return userController.currentlyLoggedInUser;
}

void logoutUser() {
  if (userController.currentlyLoggedInUser != null) {
    userController.logoutUser();
  }
}

Color backgroundResourcesColor = Colors.black;
double blueIconsSize = 25;

Widget getCircularProgressBar() =>
    Center(child: CircularProgressIndicator(color: backgroundResourcesColor));

void getSnapbar(String title, message, {Icon? icon, Color? borderColor}) {
  Get.showSnackbar(
    GetSnackBar(
      titleText: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: MyApplication.attractiveColor1,
        ),
      ),
      messageText: Text(
        message,
        style: TextStyle(fontSize: 18, color: Colors.black),
      ),
      snackPosition: SnackPosition.TOP,
      margin: EdgeInsets.symmetric(horizontal: 15),
      borderRadius: 20,
      borderColor: borderColor ?? Colors.red,
      borderWidth: 5,
      backgroundColor: MyApplication.logoColor2,
      icon: icon ?? Icon(Icons.error, color: borderColor ?? borderColor),
      shouldIconPulse: false,
      duration: const Duration(seconds: 3),
    ),
  );
}

bool containsPlusAndNumbersOnly(String phoneNumber) {
  if (phoneNumber[0] != '+' || phoneNumber[1] != '2' || phoneNumber[2] != '7') {
    return false;
  }
  for (var charIndex = 3; charIndex < phoneNumber.length; charIndex++) {
    if (!(phoneNumber[charIndex] == '0' ||
        phoneNumber[charIndex] == '1' ||
        phoneNumber[charIndex] == '2' ||
        phoneNumber[charIndex] == '3' ||
        phoneNumber[charIndex] == '4' ||
        phoneNumber[charIndex] == '5' ||
        phoneNumber[charIndex] == '6' ||
        phoneNumber[charIndex] == '7' ||
        phoneNumber[charIndex] == '8' ||
        phoneNumber[charIndex] == '9')) {
      return false;
    }
  }
  return true;
}

String trimmedURL(String untrimmedURL) {
  if (untrimmedURL.isEmpty ||
      (!untrimmedURL.contains('/o/') && !untrimmedURL.contains('?'))) {
    return untrimmedURL;
    // return "";
  }

  return untrimmedURL
      .substring(untrimmedURL.indexOf('/o/') + 2, untrimmedURL.indexOf('?'))
      .replaceAll('%2F', '/')
      .replaceAll('%20', ' ')
      .replaceAll('%2B', '+');
}

bool isValidPhoneNumber(String phoneNumber) {
  return phoneNumber.isNotEmpty &&
      phoneNumber.length == 12 &&
      containsPlusAndNumbersOnly(phoneNumber) &&
      (phoneNumber.startsWith('+276') ||
          phoneNumber.startsWith('+277') ||
          phoneNumber.startsWith('+278'));
}

Widget popupMenuButton() => PopupMenuButton<String>(
  color: Colors.black,

  icon: Icon(
    Icons.more_vert,
    color: MyApplication.backArrowColor,
  ), // Displays the 3 vertical dots
  onSelected: (value) {
    // Handle menu selection
    switch (value) {
      case 'Alcohol':
        sharedResourcesController.setPostFor(PostFor.alcohol);
        break;
      default:
        sharedResourcesController.setPostFor(PostFor.clothing);
    }
  },
  itemBuilder: (BuildContext context) {
    return {'Clothing', 'Alcohol'}.map((String choice) {
      return PopupMenuItem<String>(
        value: choice,
        child: Text(
          choice,
          style: TextStyle(color: MyApplication.storesTextColor),
        ),
      );
    }).toList();
  },
);

Widget retrieveTextField(
  String description,
  TextEditingController controller, {
  Color? color,
  IconData? iconData,
  double? fontSize,
  TextInputType? textType,
  int? minLines = 1,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 15),
    child: TextField(
      keyboardType: textType,
      maxLines: 10,
      minLines: minLines,
      style: TextStyle(color: MyApplication.scaffoldBodyColor),
      cursorColor: MyApplication.scaffoldBodyColor,
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: iconData == null
            ? null
            : Icon(iconData, color: MyApplication.logoColor1),
        labelText: description,
        helperMaxLines: 10,
        labelStyle: TextStyle(
          fontSize: fontSize ?? 14,
          color: color == null
              ? MyApplication.logoColor1
              : MyApplication.logoColor2,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(
            color: color == null
                ? MyApplication.logoColor1
                : MyApplication.logoColor2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: MyApplication.logoColor1),
        ),
      ),
      obscureText: false,
    ),
  );
}

class Globals {
  const Globals._();

  //static final auth = FirebaseAuth.instance;

  //static User? get firebaseUser => auth.currentUser;

  static final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
}
