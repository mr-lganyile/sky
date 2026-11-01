import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sky/screens/utils/globals.dart';
import '../../controllers/alcohol_post_controller.dart';
import '../../controllers/clothing_post_controller.dart';
import '../../main.dart';
import '/models/posts/identifeir_symbol.dart';

import 'dart:developer' as debug;

class IdentifierSymbolPositionWidget extends StatefulWidget {
  int atPosition;

  IdentifierSymbolPositionWidget({required this.atPosition});

  @override
  State<IdentifierSymbolPositionWidget> createState() =>
      IdentifierSymbolPositionWidgetState();
}

class IdentifierSymbolPositionWidgetState
    extends State<IdentifierSymbolPositionWidget> {
  final double identifierFontSize = 25;
  final FontWeight identifierFontWeight = FontWeight.bold;
  ClothingPostController postController =
      ClothingPostController.clothingPostController;

  Color bodyColor = const Color.fromARGB(0, 243, 79, 33);

  @override
  void initState() {
    super.initState();
  }

  Widget dragTarget() => DragTarget(
    onLeave: (data) {
      debug.log('data leaves...');
    },
    onAcceptWithDetails: (details) {
      // make sure we only add where we never added before.

      IdentifeirSymbol identifierSymbol = details.data as IdentifeirSymbol;

      if (postController.clothing.clothsPostImageURL!.isEmpty) {
        getSnapbar('Error', 'Image Not Uploaded Yet.');
      } else if (!postController.clothing.canAddMoreCloths()) {
        getSnapbar('Error', 'Cloths Limit Reached.');
      } else if (postController.allowMovementOfDraggable &&
          postController.canAddOnGridPosition(widget.atPosition)) {
        identifierSymbol.setIsUsed(true);
        debug.log(identifierSymbol.toString());
        postController.updateGridPositions(widget.atPosition, identifierSymbol);
        postController.updateAlreadyPlacedIdentifeirSymbolsIndices(
          identifierSymbol.identifeirIndex,
        );
        postController.setCurrentIdentifeirSymbol(identifierSymbol);
      }
    },

    // called repeatedly
    builder: (context, candidateData, rejectedData) {
      if (postController.gridPositions[widget.atPosition].identifeirSymbol !=
          null) {
        return Container(
          alignment: Alignment.center,
          color: bodyColor,
          child: Text(
            postController.gridPositions[widget.atPosition].identifeirSymbol!
                .getSymbol(),
            style: TextStyle(
              color: MyApplication.storesTextColor,
              fontWeight: identifierFontWeight,
              fontSize: identifierFontSize,
            ),
          ),
        );
      } else if (candidateData.isEmpty || candidateData.first == null) {
        return Container(color: bodyColor);
      } else {
        IdentifeirSymbol idSymbol = candidateData.first as IdentifeirSymbol;
        return Container(
          alignment: Alignment.center,
          color: bodyColor,
          child: Text(
            idSymbol.getSymbol(),
            style: TextStyle(
              color: MyApplication.storesTextColor,
              fontWeight: identifierFontWeight,
              fontSize: identifierFontSize,
            ),
          ),
        );
      }
    },
  );

  // Widget ready for close testing.
  @override
  Widget build(BuildContext context) => GetBuilder<ClothingPostController>(
    builder: (_) {
      return dragTarget();
    },
  );
}
