import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
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
    // remember so far there are 8 possible reactions.
    if (countNumberOfDigits <= 9) {
      debug.log('$countNumberOfDigits width * 1.5');
      return width * 1.5;
    } else if (countNumberOfDigits <= 18) {
      debug.log('$countNumberOfDigits width * 1.7');
      return width * 1.7;
    } else if (countNumberOfDigits <= 27) {
      debug.log('$countNumberOfDigits width * 1.9');
      return width * 1.9;
    } else {
      debug.log('$countNumberOfDigits width * 2');
      return width * 2;
    }
  }

  void manageReaction(int orderIndex, Trackable trackable, bool increase) {
    postController.updateTrackableQuantify(
      widget.post.postId,
      orderIndex,
      trackable,
      increase,
    );
  }

  Widget identifeirSymbolsInfo(
    int orderIndex,
    IdentifeirSymbol identifierSymbol,
  ) {
    double fontSize = 15;
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
                    // award
                    IconButton(
                      color: Colors.white,
                      iconSize: MediaQuery.of(context).size.width * 0.06,
                      icon: HugeIcon(
                        icon: HugeIcons.strokeRoundedAward01,
                        color: Colors.lightGreen,
                        size: 24.0,
                      ),
                      onPressed: () async {
                        manageReaction(
                          orderIndex,
                          Trackable.numberOfAwards,
                          true,
                        );
                      },
                    ),
                    // no of awards
                    Text(
                      Converter.convertNoOfReactions(
                        identifierSymbol.numberOfAwards!,
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
                      icon: HugeIcon(
                        icon: HugeIcons.strokeRoundedInLove,
                        color: Colors.lightGreen,
                        size: 24.0,
                      ),
                      onPressed: () async {
                        manageReaction(
                          orderIndex,
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

                    // hand shake icon
                    IconButton(
                      color: Colors.white,
                      iconSize: MediaQuery.of(context).size.width * 0.06,
                      icon: HugeIcon(
                        icon: HugeIcons.strokeRoundedHandshake,
                        color: Colors.lightGreen,
                        size: 24.0,
                      ),
                      onPressed: () async {
                        manageReaction(
                          orderIndex,
                          Trackable.numberOfHandShakes,
                          true,
                        );
                      },
                    ),
                    // no of hand shakes
                    Text(
                      Converter.convertNoOfReactions(
                        identifierSymbol.numberOfHandShakes!,
                      ),
                      style: TextStyle(
                        color: MyApplication.storesTextColor,
                        fontWeight: identifierFontWeight,
                        fontSize: fontSize,
                      ),
                    ),

                    // gqa icon
                    IconButton(
                      color: Colors.white,
                      iconSize: MediaQuery.of(context).size.width * 0.06,
                      icon: HugeIcon(
                        icon: HugeIcons.strokeRoundedPunch,
                        color: Colors.lightGreen,
                        size: 24.0,
                      ),
                      onPressed: () async {
                        manageReaction(orderIndex, Trackable.numberOfGqa, true);
                      },
                    ),
                    // no of gqa
                    Text(
                      Converter.convertNoOfReactions(
                        identifierSymbol.numberOfGqa!,
                      ),
                      style: TextStyle(
                        color: MyApplication.storesTextColor,
                        fontWeight: identifierFontWeight,
                        fontSize: fontSize,
                      ),
                    ),

                    // kiss
                    IconButton(
                      color: Colors.white,
                      iconSize: MediaQuery.of(context).size.width * 0.06,
                      icon: HugeIcon(
                        icon: HugeIcons.strokeRoundedKissing,
                        color: Colors.lightGreen,
                        size: 24.0,
                      ),
                      onPressed: () async {
                        manageReaction(
                          orderIndex,
                          Trackable.numberOfKisses,
                          true,
                        );
                      },
                    ),
                    // no of kisses
                    Text(
                      Converter.convertNoOfReactions(
                        identifierSymbol.numberOfKisses!,
                      ),
                      style: TextStyle(
                        color: MyApplication.storesTextColor,
                        fontWeight: identifierFontWeight,
                        fontSize: fontSize,
                      ),
                    ),

                    // daught
                    IconButton(
                      color: Colors.white,
                      iconSize: MediaQuery.of(context).size.width * 0.06,
                      icon: HugeIcon(
                        icon: HugeIcons.strokeRoundedMonocle01,
                        color: Colors.red,
                        size: 24.0,
                      ),
                      onPressed: () async {
                        manageReaction(
                          orderIndex,
                          Trackable.numberOfDaught,
                          true,
                        );
                      },
                    ),
                    // no of daught
                    Text(
                      Converter.convertNoOfReactions(
                        identifierSymbol.numberOfDaught!,
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
                      icon: HugeIcon(
                        icon: HugeIcons.strokeRoundedDispleased,
                        color: Colors.red,
                        size: 24.0,
                      ),
                      onPressed: () async {
                        manageReaction(
                          orderIndex,
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

                    // falling asleep
                    IconButton(
                      color: Colors.white,
                      iconSize: MediaQuery.of(context).size.width * 0.06,
                      icon: HugeIcon(
                        icon: HugeIcons.strokeRoundedSleeping,
                        color: Colors.red,
                        size: 24.0,
                      ),
                      onPressed: () async {
                        manageReaction(
                          orderIndex,
                          Trackable.numberOfFallingAsleep,
                          true,
                        );
                      },
                    ),
                    // no of falling asleep
                    Text(
                      Converter.convertNoOfReactions(
                        identifierSymbol.numberOfFallingAsleep!,
                      ),
                      style: TextStyle(
                        color: MyApplication.storesTextColor,
                        fontWeight: identifierFontWeight,
                        fontSize: fontSize,
                      ),
                    ),

                    // to bin icon
                    IconButton(
                      color: Colors.white,
                      iconSize: MediaQuery.of(context).size.width * 0.06,
                      icon: HugeIcon(
                        icon: HugeIcons.strokeRoundedTrash,
                        color: Colors.red,
                        size: 24.0,
                      ),
                      onPressed: () async {
                        manageReaction(
                          orderIndex,
                          Trackable.numberOfToBin,
                          true,
                        );
                      },
                    ),
                    // no of to bin
                    Text(
                      Converter.convertNoOfReactions(
                        identifierSymbol.numberOfToBin!,
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
        SizedBox(height: 10),
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
                    itemBuilder: ((context, orderIndex) {
                      return identifeirSymbolsInfo(
                        orderIndex,
                        widget.post.clothing.identifierSymbols[orderIndex]!,
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
