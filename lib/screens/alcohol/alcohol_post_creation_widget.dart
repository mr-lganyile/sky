import '/controllers/language_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:developer' as debug;

import '../../controllers/alcohol_post_controller.dart';
import '../../main.dart';
import 'package:video_player/video_player.dart';

import '../utils/globals.dart';
import '../utils/post_display_screen.dart';

class AlcoholPostCreationWidget extends StatefulWidget {
  AlcoholPostCreationWidget();

  @override
  State<StatefulWidget> createState() => AlcoholPostCreationWidgetState();
}

class AlcoholPostCreationWidgetState extends State<AlcoholPostCreationWidget> {
  AlcoholPostController postController =
      AlcoholPostController.alcoholPostController;
  LanguageController languageController = LanguageController.languageController;
  TextEditingController whereWereYouController = TextEditingController();
  TextEditingController whoWereYouWithController = TextEditingController();
  TextEditingController whatHappenedController = TextEditingController();
  TextEditingController whatWereYouDrinkingController = TextEditingController();

  double horizontalImageDisplayPadding = 15;

  // I'm not sure where to dispose these controllers.
  VideoPlayerController? whereWereYouVideoController;
  VideoPlayerController? whoWereYouWithVideoController;
  VideoPlayerController? whatHappenedVideoController;

  double uploadIconsSize = 50;
  Color uploadIconColor = MyApplication.logoColor2;

  AlcoholPostCreationWidgetState();

  @override
  void initState() {
    // initializeRecorders();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String displayRecordingTime(int seconds) {
    int numOfMinutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;

    if (numOfMinutes > 59) {
      getSnapbar('Warning', 'Recording Took Too Long');
      return "--:--";
    }

    String minutesString = "";

    if (numOfMinutes < 10) {
      minutesString += "0$numOfMinutes";
    } else {
      minutesString += numOfMinutes.toString();
    }

    String secondsString = "";

    if (remainingSeconds < 10) {
      secondsString += "0$remainingSeconds";
    } else {
      secondsString += remainingSeconds.toString();
    }

    // debug.log("$minutesString:$secondsString");

    return "$minutesString:$secondsString";
  }

  Widget buildPlayIcon(bool forVideo, String url) {
    return Expanded(
      child: SizedBox(
        height: MyApplication.alarmIconFontSize,
        width: MyApplication.alarmIconFontSize,
        child: IconButton(
          onPressed: () {
            // Play record or video
            debug.log('play button pressed...');

            // Play Video On Button Click.
            if (forVideo) {
            }
            // Play Record On Button Click.
            else {}
          },
          icon: Icon(
            Icons.play_circle,
            color: MyApplication.logoColor1,
            size: MyApplication.alarmIconFontSize,
          ),
        ),
      ),
    );
  }

  Widget buildVideoDisplay(int questionNumberIndex) {
    VideoPlayer? widget;
    switch (questionNumberIndex) {
      case 0:
        if (whereWereYouVideoController != null) {
          widget = VideoPlayer(whereWereYouVideoController!);
        }
        break;
      case 1:
        if (whoWereYouWithVideoController != null) {
          widget = VideoPlayer(whoWereYouWithVideoController!);
        }
        break;
      case 2:
        if (whatHappenedVideoController != null) {
          widget = VideoPlayer(whatHappenedVideoController!);
        }
    }

    if (widget == null) return const SizedBox.square();

    return Builder(
      builder: (context) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 1.8,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: widget,
          ),
        );
      },
    );
  }

  void disposeVideoControllers() {
    if (whereWereYouVideoController != null) {
      whereWereYouVideoController!.dispose();
    }
    if (whoWereYouWithVideoController != null) {
      whoWereYouWithVideoController!.dispose();
    }
    if (whatHappenedVideoController != null) {
      whatHappenedVideoController!.dispose();
    }
  }

  Widget whereWereYouDisplayImage() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalImageDisplayPadding),
      child: AspectRatio(
        aspectRatio: 2 / 2,
        child: CachedNetworkImage(
          key: UniqueKey(),
          fit: BoxFit.cover,
          imageUrl: postController.whereWereYouImageURL,
          fadeOutCurve: Curves.easeOutExpo,
          imageBuilder: (c, provider) {
            return Container(
              //margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/8) ,
              decoration: BoxDecoration(
                color: backgroundResourcesColor,
                borderRadius: BorderRadius.circular(20),
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
        ),
      ),
    );
  }

  Widget whereWereYouDisplay() {
    // Where were you? Image Uploaded
    if (postController.whereWereYouImage != null) {
      return whereWereYouDisplayImage();
    }
    // Where were you? Voice Record Uploaded
    else if (postController.whereWereYouVoiceRecord != null &&
        postController.whereWereYouVoiceRecordURL.isNotEmpty) {
      return buildPlayIcon(false, postController.whereWereYouVoiceRecordURL);
    }
    // Where were you? Video Uploaded
    else if (postController.whereWereYouVideo != null) {
      debug.log('About to display the video.');
      whereWereYouVideoController = VideoPlayerController.file(
        postController.whereWereYouVideo!,
      );
      whereWereYouVideoController!.initialize();
      whereWereYouVideoController!.setVolume(10);
      whereWereYouVideoController!.setLooping(false);
      whereWereYouVideoController!.play();
      return buildVideoDisplay(0);
    } else {
      // Where were you? Text Written
      return const SizedBox.shrink();
    }
  }

  Widget whereWereYouUploadIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                postController.clearForWhereWereYouImage();
                postController.captureWhereWereYouImage();
              },
              icon: const Icon(Icons.camera_alt),
              iconSize: uploadIconsSize,
              color: uploadIconColor,
            ),
          ),
        ),
        /*
        Expanded(
            child: Column(
          children: [
            IconButton(
              onPressed: () async {
                postController.clearForWhereWereYouVoiceRecord();
                // record
                if (whereWereYouRecorder.isRecording) {
                  await stop(0);
                } else {
                  await record(0);
                }
              },
              icon: Icon(
                  !whereWereYouRecorder.isRecording ? Icons.mic : Icons.stop),
              iconSize: uploadIconsSize,
              color: uploadIconColor,
            ),
            StreamBuilder<RecordingDisposition>(
              stream: whereWereYouRecorder.onProgress,
              builder: (context, snapshot) {
                final duration =
                    snapshot.hasData ? snapshot.data!.duration : Duration.zero;

                return Text(
                  displayRecordingTime(duration.inSeconds),
                  style: TextStyle(color: MyApplication.attractiveColor1),
                );
              },
            ),
          ],
        )),
        
        Expanded(
            child: IconButton(
          onPressed: () {
            postController.clearForWhereWereYouVideo();
            postController.captureWhereWereYouVideo(ImageSource.camera);
          },
          icon: const Icon(Icons.video_camera_back),
          iconSize: uploadIconsSize,
          color: uploadIconColor,
        )), */
      ],
    );
  }

  Widget whoWereYouWithDisplayImage() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalImageDisplayPadding),
      child: AspectRatio(
        aspectRatio: 2 / 2,
        child: CachedNetworkImage(
          key: UniqueKey(),
          fit: BoxFit.cover,
          imageUrl: postController.whoWereYouWithImageURL,
          fadeOutCurve: Curves.easeOutExpo,
          imageBuilder: (c, provider) {
            return Container(
              //margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/8) ,
              decoration: BoxDecoration(
                color: backgroundResourcesColor,
                borderRadius: BorderRadius.circular(20),
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
        ),
      ),
    );
  }

  Widget whoWereYouWithDisplay() {
    // Who were you with? Image Uploaded
    if (postController.whoWereYouWithImage != null) {
      return whoWereYouWithDisplayImage();
    }
    // Who were you with? Voice Record Uploaded
    else if (postController.whoWereYouWithVoiceRecord != null &&
        postController.whoWereYouWithVoiceRecordURL.isNotEmpty) {
      return buildPlayIcon(false, postController.whoWereYouWithVoiceRecordURL);
    }
    // Who were you with? Video Uploaded
    else if (postController.whoWereYouWithVideo != null) {
      whoWereYouWithVideoController = VideoPlayerController.file(
        postController.whoWereYouWithVideo!,
      );
      whoWereYouWithVideoController!.initialize();
      whoWereYouWithVideoController!.setVolume(10);
      whoWereYouWithVideoController!.setLooping(false);
      return buildVideoDisplay(1);
    } else {
      // Who were you with? Text Written
      return const SizedBox.shrink();
    }
  }

  Widget whoWereYouWithUploadIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () {
                postController.clearForWhoWereYouWithImage();
                postController.captureWhoWereYouWithImage();
              },
              icon: const Icon(Icons.camera_alt),
              iconSize: uploadIconsSize,
              color: uploadIconColor,
            ),
          ),
        ),
        /*
        Expanded(
            child: Column(
          children: [
            IconButton(
              onPressed: () async {
                postController.clearForWhoWereYouWithVoiceRecord();
                // Record
                if (whoWereYouWithRecorder.isRecording) {
                  await stop(1);
                } else {
                  await record(1);
                }
              },
              icon: Icon(
                  !whoWereYouWithRecorder.isRecording ? Icons.mic : Icons.stop),
              iconSize: uploadIconsSize,
              color: uploadIconColor,
            ),
            StreamBuilder<RecordingDisposition>(
              stream: whoWereYouWithRecorder.onProgress,
              builder: (context, snapshot) {
                final duration =
                    snapshot.hasData ? snapshot.data!.duration : Duration.zero;

                return Text(
                  displayRecordingTime(duration.inSeconds),
                  style: TextStyle(color: MyApplication.attractiveColor1),
                );
              },
            ),
          ],
        )),
        
        Expanded(
            child: IconButton(
          onPressed: () {
            postController.clearForWhoWereYouWithVideo();
            postController.captureWhoWereYouWithVideo(ImageSource.camera);
          },
          icon: const Icon(Icons.video_camera_back),
          iconSize: uploadIconsSize,
          color: uploadIconColor,
        )), */
      ],
    );
  }

  Widget whatsHappenedDisplay() {
    // What happened? Voice Record Uploaded
    if (postController.whatHappenedVoiceRecord != null &&
        postController.whatHappenedVoiceRecordURL.isNotEmpty) {
      return buildPlayIcon(false, postController.whatHappenedVoiceRecordURL);
    }
    // What happened? Video Uploaded
    else if (postController.whatHappenedVideo != null) {
      whatHappenedVideoController = VideoPlayerController.file(
        postController.whatHappenedVideo!,
      );
      whatHappenedVideoController!.initialize();
      whatHappenedVideoController!.setVolume(10);
      whatHappenedVideoController!.setLooping(false);

      return buildVideoDisplay(2);
    }

    // What happened? Text Written
    return const SizedBox.shrink();
  }

  Widget whatWereYouDrinkingDisplayImage() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalImageDisplayPadding),
      child: AspectRatio(
        aspectRatio: 2 / 2,
        child: CachedNetworkImage(
          key: UniqueKey(),
          fit: BoxFit.cover,
          imageUrl: postController.whatWereYouDrinkingImageURL,
          fadeOutCurve: Curves.easeOutExpo,
          imageBuilder: (c, provider) {
            return Container(
              decoration: BoxDecoration(
                color: backgroundResourcesColor,
                borderRadius: BorderRadius.circular(20),
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
        ),
      ),
    );
  }

  Widget whatWereYouDrinkingDisplay() {
    // What Were You Drinking? Image Uploaded
    if (postController.whatWereYouDrinkingImage != null) {
      return whatWereYouDrinkingDisplayImage();
    } else {
      // What Were You Drinking? Text Written
      return const SizedBox.shrink();
    }
  }

  Widget whatWereYouDrinkingUploadIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () {
                postController.clearForWhatWereYouDrinkingImage();
                postController.captureWhatWereYouDrinkingImage();
              },
              icon: const Icon(Icons.camera_alt),
              iconSize: uploadIconsSize,
              color: uploadIconColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget alcoholPostCreationPart() => Card(
    color: Colors.black,
    child: Column(
      children: [
        alcoholQuestions(),

        const SizedBox(height: 10),
        retrieveTextField(
          languageController.language.translateWhereWereYouDrinking(),
          whereWereYouController,
        ),
        const SizedBox(height: 5),
        GetBuilder<AlcoholPostController>(
          builder: (_) {
            return whereWereYouDisplay();
          },
        ),
        // whereWereYouUploadIcons(),
        const SizedBox(height: 5),
        SizedBox(
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: AbsorbPointer(
                  child: retrieveTextField(
                    languageController.language
                        .translateWhoWereYouDrinkingWith(),
                    whoWereYouWithController,
                  ),
                ),
              ),
              Expanded(
                child: IconButton(
                  onPressed: () {
                    postController.clearForWhoWereYouWithImage();
                    postController.captureWhoWereYouWithImage();
                  },
                  icon: const Icon(Icons.camera_alt),
                  iconSize: uploadIconsSize,
                  color: uploadIconColor,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        GetBuilder<AlcoholPostController>(
          builder: (context) {
            return whoWereYouWithDisplay();
          },
        ),
        // whoWereYouWithUploadIcons(),
        const SizedBox(height: 5),
        Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: AbsorbPointer(
                  child: retrieveTextField(
                    languageController.language.translateWhatHappened(),
                    whatHappenedController,
                  ),
                ),
              ),
              Expanded(
                child: IconButton(
                  onPressed: () {
                    postController.clearForWhatHappenedVideo();
                    postController.captureWhatHappenedVideo(ImageSource.camera);
                  },
                  icon: const Icon(Icons.video_camera_back),
                  iconSize: uploadIconsSize,
                  color: uploadIconColor,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        GetBuilder<AlcoholPostController>(
          builder: (_) {
            return whatsHappenedDisplay();
          },
        ),
        /*whatsHappenedUploadIcons(), */
        const SizedBox(height: 5),
        SizedBox(
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: AbsorbPointer(
                  child: retrieveTextField(
                    languageController.language.translateWhatWereYouDrinking(),
                    whatWereYouDrinkingController,
                  ),
                ),
              ),
              Expanded(
                child: IconButton(
                  onPressed: () {
                    postController.clearForWhatWereYouDrinkingImage();
                    postController.captureWhatWereYouDrinkingImage();
                  },
                  icon: const Icon(Icons.camera_alt),
                  iconSize: uploadIconsSize,
                  color: uploadIconColor,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        GetBuilder<AlcoholPostController>(
          builder: (context) {
            return whatWereYouDrinkingDisplay();
          },
        ),
      ],
    ),
  );

  Widget logo() => Container(
    height: 100,
    width: 100,
    decoration: const BoxDecoration(
      image: DecorationImage(image: AssetImage('assets/logo.png')),
      shape: BoxShape.circle,
    ),
  );

  Widget alcoholQuestions() => Container(
    margin: const EdgeInsets.symmetric(horizontal: 15),
    child: Column(
      children: [
        Center(
          child: Text(
            languageController.language.translateAnswerOneQuestionOnly(),
            style: TextStyle(
              fontSize: MyApplication.infoTextFontSize,
              color: MyApplication.scaffoldBodyColor,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                languageController.language.translateTextAsAnswer(),
                style: TextStyle(
                  fontSize: MyApplication.infoTextFontSize,
                  color: MyApplication.logoColor2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Expanded(
              child: Text(
                languageController.language.translateNoSwearing(),
                style: TextStyle(
                  fontSize: MyApplication.infoTextFontSize,
                  color: MyApplication.attractiveColor1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                languageController.language.translateImageAsAnswer(),
                style: TextStyle(
                  fontSize: MyApplication.infoTextFontSize,
                  color: MyApplication.logoColor2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Expanded(
              child: Text(
                languageController.language.translateImageMax10MB(),
                style: TextStyle(
                  fontSize: MyApplication.infoTextFontSize,
                  color: MyApplication.attractiveColor1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                languageController.language.translateVideoAsAnswer(),
                style: TextStyle(
                  fontSize: MyApplication.infoTextFontSize,
                  color: MyApplication.logoColor2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Expanded(
              child: Text(
                languageController.language.translateVideoMaxSeconds(),
                style: TextStyle(
                  fontSize: MyApplication.infoTextFontSize,
                  color: MyApplication.attractiveColor1,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  Widget postIcon() => Align(
    alignment: AlignmentGeometry.centerEnd,
    child: IconButton(
      color: MyApplication.attractiveColor1,
      iconSize: MediaQuery.of(context).size.width * 0.15,
      icon: Icon(Icons.add_circle, color: MyApplication.attractiveColor1),
      onPressed: () async {
        if (whereWereYouController.text.isNotEmpty) {
          postController.clearForWhereWereYouText();
          postController.setWhereWereYouText(whereWereYouController.text);
        }

        if (whoWereYouWithController.text.isNotEmpty) {
          postController.clearForWhoWereYouWithText();
          postController.setWhoWereYouWithText(whoWereYouWithController.text);
        }

        if (whatHappenedController.text.isNotEmpty) {
          postController.clearForWhatHappenedText();
          postController.setWhatHappedText(whatHappenedController.text);
        }

        if (whatWereYouDrinkingController.text.isNotEmpty) {
          postController.clearForWhatWereYouDrinkingText();
          postController.setWhatWereYouDrinkingText(
            whatWereYouDrinkingController.text,
          );
        }

        // Save post
        postController.saveAlcoholPost().then((value) {
          if (value == AlcoholPostStatus.postSaved) {
            // disposeVideoControllers();
            Get.to(() => PostDisplayScreen());
          }
        });
      },
    ),
  );

  Widget postButton() => Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.symmetric(horizontal: 15),
    decoration: BoxDecoration(
      color: MyApplication.logoColor1,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
    ),
    child: InkWell(
      onTap: () async {
        if (whereWereYouController.text.isNotEmpty) {
          postController.clearForWhereWereYouText();
          postController.setWhereWereYouText(whereWereYouController.text);
        }

        if (whoWereYouWithController.text.isNotEmpty) {
          postController.clearForWhoWereYouWithText();
          postController.setWhoWereYouWithText(whoWereYouWithController.text);
        }

        if (whatHappenedController.text.isNotEmpty) {
          postController.clearForWhatHappenedText();
          postController.setWhatHappedText(whatHappenedController.text);
        }

        if (whatWereYouDrinkingController.text.isNotEmpty) {
          postController.clearForWhatWereYouDrinkingText();
          postController.setWhatWereYouDrinkingText(
            whatWereYouDrinkingController.text,
          );
        }

        // Save post
        postController.saveAlcoholPost().then((value) {
          if (value == AlcoholPostStatus.postSaved) {
            // disposeVideoControllers();
            Get.to(() => PostDisplayScreen());
          } else if (value == AlcoholPostStatus.loginRequired) {
            Get.snackbar('Error', 'Login Required.');
          } else if (value == AlcoholPostStatus.answerAtleastOneQuestion) {
            Get.snackbar('Error', 'Answer Atleast One Question.');
          }
        });
      },
      child: const Center(
        child: Text(
          'Post',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        logo(),
        const SizedBox(height: 10),
        alcoholPostCreationPart(),
        const SizedBox(height: 5),

        // Create Post
        // postButton(),
        postIcon(),
        const SizedBox(height: 5),
      ],
    );
  }
}
