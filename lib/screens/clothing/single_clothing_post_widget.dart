import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../controllers/clothing_post_controller.dart';
import '../../models/posts/trackable.dart';
import '/models/posts/clothing_post.dart';
import '/models/posts/identifeir_symbol.dart';
import 'dart:developer' as debug;

import '../../main.dart';
import '../../models/converter.dart';
import '../utils/globals.dart';

class SingleClothingPostWidget extends StatefulWidget {
  ClothingPost post;

  SingleClothingPostWidget({required this.post});

  @override
  State<StatefulWidget> createState() => SingleClothingPostState();
}

class SingleClothingPostState extends State<SingleClothingPostWidget> {
  final double identifierFontSize = 25;
  final FontWeight identifierFontWeight = FontWeight.bold;
  ClothingPostController postController =
      ClothingPostController.clothingPostController;
  double horizontalImageDisplayPadding = 15;

  @override
  void initState() {
    super.initState();
  }

  double calculateReactionsSpace(double width, int countNumberOfDigits) {
    if (countNumberOfDigits <= 10) {
      return width;
    } else if (countNumberOfDigits <= 15) {
      return width + width * 0.1;
    } else {
      return width + width * 0.2;
    }
  }

  void manageReaction(int identifeirIndex, Trackable trackable, bool increase) {
    Future<TrackableUpdateStatus> status = postController
        .updateTrackableQuantify(
          widget.post.postId,
          identifeirIndex,
          trackable,
          increase,
        );

    status.then((value) {
      if (value == TrackableUpdateStatus.liked) {
        getSnapbar('Info', 'Like Noted');
      } else if (value == TrackableUpdateStatus.disliked) {
        getSnapbar('Info', 'Dislike Noted');
      } else if (value == TrackableUpdateStatus.huged) {
        getSnapbar('Info', 'Hug Noted');
      } else if (value == TrackableUpdateStatus.ignored) {
        getSnapbar('Info', 'Ignore Noted');
      } else if (value == TrackableUpdateStatus.phoneNumberRequested) {
        getSnapbar('Info', 'Phone Number Request Noted');
      }
    });
  }

  Widget identifeirSymbolsInfo(IdentifeirSymbol identifierSymbol) {
    double fontSize = 15;
    Color actionIconColor = MyApplication.attractiveColor1;
    return Builder(
      builder: (context) {
        return SizedBox(
          width: calculateReactionsSpace(
            MediaQuery.of(context).size.width,
            identifierSymbol.computeNumberOfReactionDigits(),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Clothing Name As
                  Expanded(
                    child: Text(
                      identifierSymbol.findClothingNameAs(),
                      style: TextStyle(
                        color: MyApplication.storesTextColor,
                        fontSize: fontSize,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  // Brand Name
                  Expanded(
                    flex: 3,
                    child: Text(
                      identifierSymbol.clothingName,
                      style: TextStyle(
                        color: MyApplication.storesTextColor,
                        fontSize: fontSize,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  // price tag
                  Expanded(
                    child: Text(
                      'Price',
                      style: TextStyle(
                        color: MyApplication.storesTextColor,
                        fontSize: fontSize,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  // price
                  Expanded(
                    flex: 3,
                    child: identifierSymbol.clothingPrice == null
                        ? SizedBox.shrink()
                        : Text(
                            'R${identifierSymbol.clothingPrice}',
                            style: TextStyle(
                              color: MyApplication.storesTextColor,
                              fontSize: fontSize,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.001,
                ),
                // note so far a maximum of 4 digits for each reaction can be displays without having any textoverflow error.
                child: Row(
                  children: [
                    // hug
                    IconButton(
                      color: Colors.white,
                      iconSize: MediaQuery.of(context).size.width * 0.06,
                      icon: Icon(
                        Icons.hourglass_bottom,
                        color: actionIconColor,
                      ),
                      onPressed: () async {
                        manageReaction(
                          identifierSymbol.identifeirIndex,
                          Trackable.numberOfHugs,
                          true,
                        );
                      },
                    ),
                    // no of hugs
                    Text(
                      Converter.convertNoOfReactions(
                        identifierSymbol.numberOfHugs!,
                      ),
                      style: TextStyle(
                        color: MyApplication.storesTextColor,
                        fontWeight: identifierFontWeight,
                        fontSize: fontSize,
                      ),
                    ),
                    // phone number request
                    IconButton(
                      color: Colors.white,
                      iconSize: MediaQuery.of(context).size.width * 0.06,
                      icon: Icon(Icons.phone, color: actionIconColor),
                      onPressed: () async {
                        manageReaction(
                          identifierSymbol.identifeirIndex,
                          Trackable.numberOfPhoneNumberRequests,
                          true,
                        );
                      },
                    ),
                    // no of phone number request
                    Text(
                      Converter.convertNoOfReactions(
                        identifierSymbol.numberOfPhoneNumberRequests!,
                      ),
                      style: TextStyle(
                        color: MyApplication.storesTextColor,
                        fontWeight: identifierFontWeight,
                        fontSize: fontSize,
                      ),
                    ),

                    // ignore
                    IconButton(
                      color: Colors.white,
                      iconSize: MediaQuery.of(context).size.width * 0.06,
                      icon: Icon(
                        Icons.hourglass_bottom,
                        color: actionIconColor,
                      ),
                      onPressed: () async {
                        manageReaction(
                          identifierSymbol.identifeirIndex,
                          Trackable.numberOfIgnores,
                          true,
                        );
                      },
                    ),
                    // no of ignores
                    Text(
                      Converter.convertNoOfReactions(
                        identifierSymbol.numberOfIgnores!,
                      ),
                      style: TextStyle(
                        color: MyApplication.storesTextColor,
                        fontWeight: identifierFontWeight,
                        fontSize: fontSize,
                      ),
                    ),

                    // likes icon
                    IconButton(
                      color: Colors.white,
                      iconSize: MediaQuery.of(context).size.width * 0.06,
                      icon: Icon(Icons.arrow_upward, color: actionIconColor),
                      onPressed: () async {
                        manageReaction(
                          identifierSymbol.identifeirIndex,
                          Trackable.numberOfLikes,
                          true,
                        );
                      },
                    ),
                    // no of likes
                    Text(
                      Converter.convertNoOfReactions(
                        identifierSymbol.numberOfLikes!,
                      ),
                      style: TextStyle(
                        color: MyApplication.storesTextColor,
                        fontWeight: identifierFontWeight,
                        fontSize: fontSize,
                      ),
                    ),
                    // dislike icon
                    IconButton(
                      color: Colors.white,
                      iconSize: MediaQuery.of(context).size.width * 0.06,
                      icon: Icon(Icons.arrow_downward, color: actionIconColor),
                      onPressed: () async {
                        manageReaction(
                          identifierSymbol.identifeirIndex,
                          Trackable.numberOfDislikes,
                          true,
                        );
                      },
                    ),
                    // no of dislikes
                    Text(
                      Converter.convertNoOfReactions(
                        identifierSymbol.numberOfDislikes!,
                      ),
                      style: TextStyle(
                        color: MyApplication.storesTextColor,
                        fontWeight: identifierFontWeight,
                        fontSize: fontSize,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(right: 5.0, left: 5.0, top: 10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        heading(),

        displayImage(),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Card(
                color: Colors.black.withBlue(30),
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: SizedBox(
                  height: 90,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.post.clothing.identifierSymbols.length,
                    itemBuilder: ((context, index) {
                      return identifeirSymbolsInfo(
                        widget.post.clothing.identifierSymbols[index]!,
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

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

  Widget displayImage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: AspectRatio(
        // aspectRatio: 2 / 3,
        aspectRatio: 2 / 2,
        child: FutureBuilder(
          future: findFullURL(widget.post.clothing.clothsPostImageURL!),
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
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: provider,
                      ),
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
              debug.log('Error Fetching Post Image - ${snapshot.error}');
              return getCircularProgressBar();
            } else {
              return getCircularProgressBar();
            }
          },
        ),
      ),
    );
  }
}
