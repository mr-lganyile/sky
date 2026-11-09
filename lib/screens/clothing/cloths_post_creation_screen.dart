import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/clothing_post_controller.dart';
import '../authentication/login_widget.dart';
import '../utils/post_display_screen.dart';
import '/models/posts/clothing.dart';
import '/main.dart';
import '/models/posts/identifeir_symbol.dart';
import '/screens/utils/globals.dart';
import 'clothing_post_display_screen.dart';
import 'identifeir_symbols_grid_widget.dart';
import 'dart:developer' as debug;

class ClothsPostCreationScreen extends StatefulWidget {
  ClothsPostCreationScreen();

  @override
  State createState() => ClothsPostCreationState();
}

class ClothsPostCreationState extends State<ClothsPostCreationScreen> {
  final double initialXCoordinate = 50;
  final double initialYCoordinate = 50;
  final double identifierGab = 50;
  final double identifierFontSize = 25;
  final FontWeight identifierFontWeight = FontWeight.bold;

  double horizontalImageDisplayPadding = 15;
  double uploadIconsSize = 50;
  Color uploadIconColor = MyApplication.logoColor2;
  ClothingPostController postController =
      ClothingPostController.clothingPostController;

  TextEditingController brandNameController = TextEditingController();
  TextEditingController brandPriceController = TextEditingController();

  int currentlySelectedIdentifierIndex = 0;
  List<IdentifeirSymbol> identifierSymbols = [];

  ClothsPostCreationState();

  @override
  void initState() {
    super.initState();

    identifierSymbols.add(
      IdentifeirSymbol(clothingName: 'Hart', identifeirIndex: 0),
    );
    identifierSymbols.add(
      IdentifeirSymbol(clothingName: 'Shades', identifeirIndex: 1),
    );
    identifierSymbols.add(
      IdentifeirSymbol(clothingName: 'Hair', identifeirIndex: 2),
    );
    identifierSymbols.add(
      IdentifeirSymbol(clothingName: 'TShirt', identifeirIndex: 3),
    );
    identifierSymbols.add(
      IdentifeirSymbol(clothingName: 'Jacket', identifeirIndex: 4),
    );
    identifierSymbols.add(
      IdentifeirSymbol(clothingName: 'Trauser', identifeirIndex: 5),
    );
    identifierSymbols.add(
      IdentifeirSymbol(clothingName: 'Shoes', identifeirIndex: 6),
    );
  }

  Future<String> retrieveGrandPriceImageURL(String clothsPostImageURL) {
    return reference.child(clothsPostImageURL).getDownloadURL();
  }

  Widget showClothsPostImage(String clothsPostImageURL) {
    return FutureBuilder(
      future: retrieveGrandPriceImageURL(clothsPostImageURL),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Center(
            child: CachedNetworkImage(
              key: UniqueKey(),
              fit: BoxFit.cover,
              imageUrl: snapshot.data as String,
              fadeOutCurve: Curves.easeOutExpo,
              imageBuilder: (c, provider) {
                return Container(
                  margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
                  height: double.maxFinite,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: backgroundResourcesColor,
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(image: provider, fit: BoxFit.cover),
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
          );
        } else if (snapshot.hasError) {
          return getCircularProgressBar();
        } else {
          return getCircularProgressBar();
        }
      },
    );
  }

  Widget postIcon() => Align(
    alignment: AlignmentGeometry.centerEnd,
    child: IconButton(
      color: MyApplication.attractiveColor1,
      iconSize: MediaQuery.of(context).size.width * 0.15,
      icon: Icon(Icons.add_circle, color: MyApplication.attractiveColor1),
      onPressed: () async {
        Future<ClothingPostStatus> status = postController.saveClothingPost();

        status.then((value) {
          switch (value) {
            case ClothingPostStatus.loginRequired:
              getSnapbar('Error', 'Login Required');
              Get.to(() => LoginWidget());
              break;
            case ClothingPostStatus.noClothingImage:
              getSnapbar('Error', 'No Clothing Image');
              break;
            case ClothingPostStatus.noClothingIdentified:
              getSnapbar('Error', 'No Clothing Identified');
              break;
            default:
              getSnapbar('Saved', 'Post Successfully Created');
              Get.to(() => PostDisplayScreen());
          }
        });
      },
    ),
  );

  Widget prevIcon() => IconButton(
    color: Colors.white,
    iconSize: MediaQuery.of(context).size.width * 0.12,
    icon: Icon(Icons.skip_previous_outlined, color: MyApplication.logoColor2),
    onPressed: () async {
      debug.log('...prev pressed.');
      if (!postController.clothing.canRemoveClothing()) {
        getSnapbar('Error', 'You Have Not Yet Shown Any Clothing.');
      } else {
        int identifierIndex = postController.clothing.removeClothing();

        if (identifierIndex >= 0) {
          identifierSymbols[identifierIndex].setIsUsed(false);
          postController.removeIdentifierSymbolFromGridPosition(
            identifierIndex,
          );
          postController.updateAllowMovementOfDraggable(true);
        }
      }
    },
  );

  Widget nextIcon() => IconButton(
    color: Colors.white,
    iconSize: MediaQuery.of(context).size.width * 0.12,
    icon: Icon(Icons.skip_next_outlined, color: MyApplication.logoColor2),
    onPressed: () async {
      if (!postController.clothing.canAddMoreCloths()) {
        getSnapbar('Error', 'You Cannot Show More Clothes.');
      } else if (postController.currentIdentifeirSymbol == null) {
        getSnapbar('Error', 'Pick Something To Show.');
      } else if (brandNameController.text.isEmpty) {
        getSnapbar('Error', 'Brand Name Required.');
      } else {
        postController.currentIdentifeirSymbol!.setClothingName(
          brandNameController.text,
        );
        brandNameController.clear();

        if (brandPriceController.text.isNotEmpty) {
          postController.currentIdentifeirSymbol!.setClothingPrice(
            double.parse(brandPriceController.text),
          );
          brandPriceController.clear();
        }

        postController.addClothing();
        postController.setCurrentIdentifeirSymbol(null);
        if (postController.clothing.canAddMoreCloths()) {
          postController.updateAllowMovementOfDraggable(true);
        }
        getSnapbar(
          'Note',
          'Clothing Pointed.',
          icon: Icon(Icons.add),
          borderColor: MyApplication.logoColor1,
        );
      }
    },
  );

  Widget clothsPostImageButtons() {
    double iconSize = MediaQuery.of(context).size.width * 0.1;
    return Row(
      // mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Camera Icon
        Expanded(
          child: IconButton(
            color: Colors.white,
            iconSize: iconSize,
            icon: Icon(Icons.camera_alt, color: MyApplication.logoColor2),
            onPressed: () async {
              // postController.clearForClothsPost();
              postController.captureClothsPostImage();
            },
          ),
        ),

        // Prev Icon
        Expanded(
          child: postController.clothing.canRemoveClothing()
              ? prevIcon()
              : AbsorbPointer(child: prevIcon()),
        ),
        // Refresh Icon
        Expanded(
          child: IconButton(
            color: Colors.white,
            iconSize: MediaQuery.of(context).size.width * 0.1,
            icon: Icon(Icons.refresh, color: MyApplication.logoColor1),
            onPressed: () async {
              setState(() {
                // for the sake of clearing all the appearing identifeir symbols.
                postController.clearForNewClothing();
              });
            },
          ),
        ),
        // Next Icon
        Expanded(
          child: postController.clothing.canAddMoreCloths()
              ? nextIcon()
              : AbsorbPointer(child: nextIcon()),
        ),
        // Upload Icon
        Expanded(
          child: IconButton(
            color: Colors.white,
            iconSize: iconSize,
            icon: Icon(Icons.upload, color: MyApplication.logoColor2),
            onPressed: () async {
              // postController.clearForClothsPost();
              postController.chooseClothsPostImageFromGallery();
            },
          ),
        ),
      ],
    );
  }

  // clothes identifiers [x # $ % & * @...]
  Widget draggableIdentifier(int identityIndex) {
    return Draggable(
      maxSimultaneousDrags: 1,
      data: identifierSymbols[identityIndex],
      // On the fly widget.
      // wrap with material to remove the underline in a text.
      feedback: Material(
        child: Text(
          identifierSymbols[identityIndex].getSymbol(),
          style: TextStyle(
            color: MyApplication.attractiveColor1,
            fontWeight: identifierFontWeight,
            fontSize: identifierFontSize,
          ),
        ),
      ),
      // Left behind or remaining widget.
      childWhenDragging: SizedBox.shrink(),
      // Initial widget
      child: Text(
        identifierSymbols[identityIndex].getSymbol(),
        style: TextStyle(
          color: MyApplication.storesTextColor,
          fontWeight: identifierFontWeight,
          fontSize: identifierFontSize,
        ),
      ),

      onDragStarted: () {
        setState(() {
          currentlySelectedIdentifierIndex = identityIndex;
        });
      },
      onDragCompleted: () {
        debug.log('drag completed...');
      },
      onDragEnd: (details) {
        if (details.wasAccepted) {
          postController.updateAllowMovementOfDraggable(false);
        }
        debug.log('drag ended...');
      },
      onDraggableCanceled: (velocity, offset) {},
      onDragUpdate: (details) {},
    );
  }

  Widget addIdentifiers() => Builder(
    builder: (context) {
      // plus one
      int numberOfIdentifiers = identifierSymbols.length;
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: GetBuilder<ClothingPostController>(
          builder: (_) {
            return ListView(
              scrollDirection: Axis.horizontal,
              // clothes identifiers [x # $ % & * @...]
              children: [
                // #
                postController.isIndexUsed(0)
                    ? SizedBox.shrink()
                    : draggableIdentifier(0),

                SizedBox(
                  width:
                      MediaQuery.of(context).size.width / numberOfIdentifiers,
                ),
                // $
                postController.isIndexUsed(1)
                    ? SizedBox.shrink()
                    : draggableIdentifier(1),
                SizedBox(
                  width:
                      MediaQuery.of(context).size.width / numberOfIdentifiers,
                ),
                // x
                postController.isIndexUsed(2)
                    ? SizedBox.shrink()
                    : draggableIdentifier(2),
                SizedBox(
                  width:
                      MediaQuery.of(context).size.width / numberOfIdentifiers,
                ),
                // %
                postController.isIndexUsed(3)
                    ? SizedBox.shrink()
                    : draggableIdentifier(3),
                SizedBox(
                  width:
                      MediaQuery.of(context).size.width / numberOfIdentifiers,
                ),
                // &
                postController.isIndexUsed(4)
                    ? SizedBox.shrink()
                    : draggableIdentifier(4),
                SizedBox(
                  width:
                      MediaQuery.of(context).size.width / numberOfIdentifiers,
                ),
                // *
                postController.isIndexUsed(5)
                    ? SizedBox.shrink()
                    : draggableIdentifier(5),
                SizedBox(
                  width:
                      MediaQuery.of(context).size.width / numberOfIdentifiers,
                ),
                // @
                postController.isIndexUsed(6)
                    ? SizedBox.shrink()
                    : draggableIdentifier(6),
              ],
            );
          },
        ),
      );
    },
  );

  Widget postButton() => Builder(
    builder: (context) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        width: MediaQuery.of(context).size.width,
        height: 40,
        decoration: BoxDecoration(
          color: MyApplication.logoColor1,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: InkWell(
          onTap: () async {
            // save clothing post
            Future<ClothingPostStatus> clothingStatus = postController
                .saveClothingPost();

            clothingStatus.then((value) {
              if (value == ClothingPostStatus.loginRequired) {
                // Get.snackbar('Error', 'Login Required.');
                Get.to(() => LoginWidget());
              } else if (value == ClothingPostStatus.noClothingImage) {
                getSnapbar('Error', 'No Image Uploaded.');
              } else if (value == ClothingPostStatus.noClothingIdentified) {
                getSnapbar('Error', 'Identify Atleast One Clothing.');
              } else {
                getSnapbar(
                  'Saved',
                  'Post Successfully Created.',
                  icon: Icon(Icons.save_as_outlined),
                );
                Get.to(() => ClothingPostDisplayScreen());
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
    },
  );

  @override
  Widget build(BuildContext context) => Container(
    alignment: Alignment.topCenter,
    // height: double.maxFinite,
    // height: 650,
    decoration: const BoxDecoration(color: Colors.black),
    child: ListView(
      children: [
        /*SizedBox(height: 10),
        // Widget ready for close testing.
        Center(
          child: Text(
            'Cothing',
            style: TextStyle(fontSize: 20, color: MyApplication.logoColor1),
          ),
        ),*/
        // Identifeirs
        SizedBox(height: 10),
        GetBuilder<ClothingPostController>(
          builder: (_) {
            return Stack(
              children: [
                SizedBox(
                  height:
                      postController.clothing.clothsPostImageURL == null ||
                          postController.clothing.clothsPostImageURL!.isEmpty
                      ? MediaQuery.of(context).size.height * 0.4
                      : MediaQuery.of(context).size.height * 0.65,
                  child: showClothsPostImage(
                    postController.clothing.clothsPostImageURL!,
                  ),
                ),
                GetBuilder<ClothingPostController>(
                  builder: (_) => Container(
                    height:
                        postController.clothing.clothsPostImageURL == null ||
                            postController.clothing.clothsPostImageURL!.isEmpty
                        ? MediaQuery.of(context).size.height * 0.4
                        : MediaQuery.of(context).size.height * 0.65,
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: IdentifeirSymbolsGridWidget(),
                  ),
                ),
                // IdentifeirSymbolsGridWidget(),
              ],
            );
          },
        ),
        SizedBox(
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height * 0.05,
          child: addIdentifiers(),
        ),
        SizedBox(height: 10),
        // Identifeir Symbol Info
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
          child: Row(
            children: [
              // Labels
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            'Clothing',
                            style: TextStyle(
                              color: MyApplication.attractiveColor1,
                              fontWeight: identifierFontWeight,
                              fontSize: identifierFontSize - 10,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            identifierSymbols[currentlySelectedIdentifierIndex]
                                .clothingName,
                            style: TextStyle(
                              color: MyApplication.storesTextColor,
                              fontWeight: identifierFontWeight,
                              fontSize: identifierFontSize - 10,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            'Symbol',
                            style: TextStyle(
                              color: MyApplication.attractiveColor1,
                              fontWeight: identifierFontWeight,
                              fontSize: identifierFontSize - 10,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            identifierSymbols[currentlySelectedIdentifierIndex]
                                .getSymbol(),
                            style: TextStyle(
                              color: MyApplication.storesTextColor,
                              fontWeight: identifierFontWeight,
                              fontSize: identifierFontSize,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Text Fields
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Expanded(
                      child: retrieveTextField(
                        'Brand Name',
                        brandNameController,
                        fontSize: 12,
                      ),
                    ),
                    Expanded(
                      child: retrieveTextField(
                        'Brand Price',
                        brandPriceController,
                        fontSize: 12,
                        textType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Buttons [prev, refresh & next]
        SizedBox(
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height * 0.08,
          child: clothsPostImageButtons(),
        ),
        // Post button
        SizedBox(
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height * 0.08,
          //child: postButton(),
          child: postIcon(),
        ),
        SizedBox(height: 20),
      ],
    ),
  );
}
