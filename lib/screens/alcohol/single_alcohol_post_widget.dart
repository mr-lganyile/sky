import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../controllers/language_controller.dart';
import '../../controllers/alcohol_post_controller.dart';
import '../../main.dart';
import '../../models/converter.dart';
import '../../models/posts/alcohol_post.dart';
import '../utils/globals.dart';

import 'dart:developer' as debug;

class SingleAlcoholPostWidget extends StatefulWidget {
  AlcoholPost post;

  SingleAlcoholPostWidget({required this.post});

  @override
  State<SingleAlcoholPostWidget> createState() => SinglePastPostWidgetState();
}

class SinglePastPostWidgetState extends State<SingleAlcoholPostWidget> {
  VideoPlayerController? whereWereYouVideoController;
  VideoPlayerController? whoWereYouWithVideoController;
  VideoPlayerController? whatHappenedVideoController;

  AlcoholPostController postController =
      AlcoholPostController.alcoholPostController;
  LanguageController languageController = LanguageController.languageController;
  late VisibilityDetectorController visibilityDetectorController;

  bool playWhatHappenedVideo = false;

  SinglePastPostWidgetState();

  @override
  void initState() {
    super.initState();

    visibilityDetectorController = VisibilityDetectorController();
  }

  @override
  void dispose() {
    super.dispose();

    // VisibilityDetectorController.instance.updateInterval = Duration.zero;

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

  // 1. where were you? 2. who were you with? 3. what happened? 4. what were you drinking?
  Widget questionAndAnswerAsText(int questionNumber) {
    String question;
    String answer;

    switch (questionNumber) {
      case 1:
        question = languageController.language.translateWhereWasIDrinking();
        answer = widget.post.whereWereYouText;
        break;
      case 2:
        question = languageController.language.translateWhoWasDrinkingWithMe();
        answer = widget.post.whoWereYouWithText;
        break;
      case 3:
        question = languageController.language.translateWhatHappened();
        answer = widget.post.whatHappenedText;
      default:
        question = languageController.language.translateWhatWasIDrinking();
        answer = widget.post.whatWereYouDrinkingText!;
    }

    return Card(
      color: Colors.black.withBlue(30),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                question,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 16,
                  color: MyApplication.attractiveColor1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 15),
                child: Text(
                  answer,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16,
                    color: MyApplication.storesTextColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 1. who were you with? 2. what were you drinking?
  Widget questionAndAnswerAsImage(int questionNumber) {
    String question;
    String imageURL;

    if (questionNumber == 1) {
      question = languageController.language.translateWhoWasDrinkingWithMe();
      imageURL = widget.post.whoWereYouWithImageURL;
    } else {
      question = languageController.language.translateWhatWasIDrinking();
      imageURL = widget.post.whatWereYouDrinkingImageURL!;
    }
    return Card(
      color: Colors.black.withBlue(30),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 16,
                color: MyApplication.attractiveColor1,
              ),
            ),
            const SizedBox(height: 5),
            displayImage(imageURL),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }

  // 1. who were you with? 2. what happened?
  Widget questionAndAnswerAsVideo(int questionNumber) {
    String question;

    if (questionNumber == 1) {
      question = languageController.language.translateWhoWasDrinkingWithMe();
    } else {
      question = languageController.language.translateWhatHappened();
    }

    return Card(
      color: Colors.black.withBlue(30),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  question,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16,
                    color: MyApplication.attractiveColor1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 15, right: 15),
                child: buildVideoDisplay(questionNumber),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget whereWereYouWidget() {
    Widget widget = const SizedBox.shrink();

    if (this.widget.post.hasWhereWereYouText()) {
      widget = questionAndAnswerAsText(1);
    } else if (this.widget.post.hasWhereWereYouImage()) {
      widget = Card(
        color: Colors.black.withBlue(30),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  languageController.language.translateWhereWasIDrinking(),
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16,
                    color: MyApplication.attractiveColor1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  margin: const EdgeInsets.only(left: 5, right: 5),
                  child: displayImage(this.widget.post.whereWereYouImageURL),
                ),
                const SizedBox(height: 5),
              ],
            ),
          ),
        ),
      );
    } else if (this.widget.post.hasWhereWereYouVoiceRecord()) {
      // Display play button
    } else if (this.widget.post.hasWhereWereYouVideo()) {
      widget = Card(
        color: Colors.black.withBlue(30),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    languageController.language.translateWhereWasIDrinking(),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16,
                      color: MyApplication.attractiveColor1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 15, right: 15),
                  child: buildVideoDisplay(0),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return widget;
  }

  Widget whoWereYouWithWidget() {
    Widget widget = const SizedBox.shrink();

    if (this.widget.post.hasWhoWereYouWithText()) {
      widget = questionAndAnswerAsText(2);
    } else if (this.widget.post.hasWhoWereYouWithImage()) {
      widget = questionAndAnswerAsImage(1);
    } else if (this.widget.post.hasWhoWereYouWithVoiceRecord()) {
      // Display play button
    } else if (this.widget.post.hasWhoWereYouWithVideo()) {
      widget = questionAndAnswerAsVideo(1);
    }

    return widget;
  }

  Widget whatHappenedWidget() {
    Widget widget = const SizedBox.shrink();

    if (this.widget.post.hasWhatHappenedText()) {
      widget = questionAndAnswerAsText(3);
    } else if (this.widget.post.hasWhatHappenedVoiceRecord()) {
      // Display play button
    } else if (this.widget.post.hasWhatHappenedVideo()) {
      widget = questionAndAnswerAsVideo(2);
    }

    return widget;
  }

  Widget whatWereYouDrinkingWidget() {
    Widget widget = const SizedBox.shrink();

    if (this.widget.post.hasWhatWereYouDrinkingText()) {
      widget = questionAndAnswerAsText(4);
    } else if (this.widget.post.hasWhatWereYouDrinkingImage()) {
      widget = questionAndAnswerAsImage(2);
    }

    return widget;
  }

  Widget buildVideoDisplay(int questionNumberIndex) {
    Widget? widget;
    switch (questionNumberIndex) {
      case 0:
        if (whereWereYouVideoController == null) {
          widget = FutureBuilder(
            future: findFullURL(this.widget.post.whereWereYouVideoURL),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                String path = (snapshot as AsyncSnapshot<String>).data!;

                whereWereYouVideoController = VideoPlayerController.network(
                  path,
                );
                whereWereYouVideoController!.initialize();
                whereWereYouVideoController!.setVolume(10);
                whereWereYouVideoController!.setLooping(false);

                debug.log('Where Were You Video Controller Initialized.');

                return VisibilityDetector(
                  key: UniqueKey(),
                  child: GestureDetector(
                    onTap: () {
                      whereWereYouVideoController!.seekTo(Duration.zero);
                      whereWereYouVideoController!.play();
                    },
                    child: VideoPlayer(whereWereYouVideoController!),
                  ),
                  onVisibilityChanged: (visibilityInfo) {
                    if (visibilityInfo.visibleFraction == 1) {
                      whereWereYouVideoController!.play();
                    } else {
                      whereWereYouVideoController!.pause();
                    }
                  },
                );
              } else if (snapshot.hasError) {
                debug.log(
                  'Error Fetching Where Were You Post Video - ${snapshot.error}',
                );
                return getCircularProgressBar();
              } else {
                return getCircularProgressBar();
              }
            },
          );
        }

        break;
      case 1:
        if (whoWereYouWithVideoController == null) {
          widget = FutureBuilder(
            future: findFullURL(this.widget.post.whoWereYouWithVideoURL),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                String path = (snapshot as AsyncSnapshot<String>).data!;

                whoWereYouWithVideoController = VideoPlayerController.network(
                  path,
                );
                whoWereYouWithVideoController!.initialize();
                whoWereYouWithVideoController!.setVolume(10);
                whoWereYouWithVideoController!.setLooping(false);

                return VisibilityDetector(
                  key: UniqueKey(),
                  child: GestureDetector(
                    onTap: () {
                      whoWereYouWithVideoController!.seekTo(Duration.zero);
                      whoWereYouWithVideoController!.play();
                    },
                    child: VideoPlayer(whoWereYouWithVideoController!),
                  ),
                  onVisibilityChanged: (visibilityInfo) {
                    if (visibilityInfo.visibleFraction == 1) {
                      whoWereYouWithVideoController!.play();
                    } else {
                      whoWereYouWithVideoController!.pause();
                    }
                  },
                );
              } else if (snapshot.hasError) {
                debug.log(
                  'Error Fetching Post Who Were You With Video - ${snapshot.error}',
                );
                return getCircularProgressBar();
              } else {
                return getCircularProgressBar();
              }
            },
          );
        }

        break;
      case 2:
        if (whatHappenedVideoController == null) {
          widget = FutureBuilder(
            future: findFullURL(this.widget.post.whatHappenedVideoURL),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                String path = (snapshot as AsyncSnapshot<String>).data!;

                whatHappenedVideoController = VideoPlayerController.network(
                  path,
                );
                whatHappenedVideoController!.initialize();
                whatHappenedVideoController!.setVolume(10);
                whatHappenedVideoController!.setLooping(false);

                return VisibilityDetector(
                  key: UniqueKey(),
                  child: GestureDetector(
                    onTap: () {
                      whatHappenedVideoController!.seekTo(Duration.zero);
                      whatHappenedVideoController!.play();
                    },
                    child: VideoPlayer(whatHappenedVideoController!),
                  ),
                  onVisibilityChanged: (visibilityInfo) {
                    if (visibilityInfo.visibleFraction < 1) {
                      // debug.log('${visibilityInfo.visibleFraction * 100}');
                      whatHappenedVideoController!.pause();
                    } else {
                      whatHappenedVideoController!.play();
                    }
                  },
                );
              } else if (snapshot.hasError) {
                debug.log(
                  'Error Fetching What Happened Post Video - ${snapshot.error}',
                );
                return getCircularProgressBar();
              } else {
                return getCircularProgressBar();
              }
            },
          );
        }
    }

    if (widget == null) return const SizedBox.shrink();

    return Builder(
      builder: (context) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 1.8,
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: widget,
          ),
        );
      },
    );
  }

  Widget heading() => Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Expanded(
        child: FutureBuilder(
          future: findFullURL(widget.post.postCreator.profileImageURL),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return CachedNetworkImage(
                key: UniqueKey(),
                fit: BoxFit.cover,
                imageUrl: snapshot.data as String,
                fadeOutCurve: Curves.easeOutExpo,
                imageBuilder: (c, provider) {
                  return CircleAvatar(
                    radius: MediaQuery.of(context).size.width * 0.09,
                    backgroundColor: backgroundResourcesColor,
                    backgroundImage: provider,
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
              return getCircularProgressBar();
            } else {
              return getCircularProgressBar();
            }
          }),
        ),
      ),
      Expanded(
        flex: 4,
        child: Container(
          margin: const EdgeInsets.only(left: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '@${widget.post.postCreator.username}',
                //textAlign: TextAlign.center,
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: MyApplication.logoColor2,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  widget.post.passedTimeRepresentation(),
                  style: TextStyle(
                    fontSize: 12,
                    color: MyApplication.logoColor1,
                    decoration: TextDecoration.none,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Text(
                Converter.asString(widget.post.postCreator.area.sectionName),
                // textAlign: TextAlign.center,
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: MyApplication.logoColor2,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        heading(),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              whereWereYouWidget(),
              const SizedBox(height: 1),
              whoWereYouWithWidget(),
              const SizedBox(height: 1),
              whatHappenedWidget(),
              const SizedBox(height: 1),
              whatWereYouDrinkingWidget(),
            ],
          ),
        ),
      ],
    ),
  );
}
