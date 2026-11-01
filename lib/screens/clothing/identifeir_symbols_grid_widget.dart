import 'package:flutter/material.dart';
import '../../controllers/clothing_post_controller.dart';
import '/controllers/alcohol_post_controller.dart';
import '/models/posts/identifeir_symbol.dart';
import '/models/posts/identifeir_symbol_position.dart';

import 'identifier_symbol_position_widget.dart';

class IdentifeirSymbolsGridWidget extends StatelessWidget {
  double mainAxisSpacing; // vertical spaces
  double crossAxisSpacing; // horizontal spaces
  int crossAxisCount; // number of columns
  int itemCount;

  ClothingPostController postController =
      ClothingPostController.clothingPostController;

  IdentifeirSymbolsGridWidget({
    this.crossAxisCount = 10,
    this.itemCount = 80,
    this.crossAxisSpacing = 1,
    this.mainAxisSpacing = 1,
  });

  // Widget ready for close testing.
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      primary: false,
      itemCount: itemCount,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: mainAxisSpacing, // vertical spaces
        crossAxisSpacing: crossAxisSpacing,
        crossAxisCount: crossAxisCount,
      ),
      itemBuilder: (_, index) {
        if (index > ClothingPostController.maximumNumberOfPositions) {
          postController.gridPositions.add(
            IdentifeirSymbolPosition(
              row: index ~/ crossAxisCount,
              column: index % crossAxisCount,
            ),
          );
          ClothingPostController.increaseMaximumNumberOfPositions();
        }

        return IdentifierSymbolPositionWidget(atPosition: index);
      },
    );
  }
}
