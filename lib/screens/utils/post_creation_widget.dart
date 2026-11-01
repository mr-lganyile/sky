import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/shared_resources_controller.dart';
import '../alcohol/alcohol_post_creation_widget.dart';
import '../clothing/cloths_post_creation_screen.dart';

import '../../main.dart';

import 'globals.dart';

class PostCreationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      centerTitle: true,
      title: Text(
        'Create Post',
        style: TextStyle(
          fontSize: MyApplication.infoTextFontSize,
          color: MyApplication.attractiveColor1,
        ),
      ),
      backgroundColor: Colors.black,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        iconSize: blueIconsSize,
        color: MyApplication.logoColor2,
        onPressed: (() {
          Get.back();
        }),
      ),
      elevation: 0,
      actions: [popupMenuButton()],
    ),
    body: SafeArea(
      child: Container(
        decoration: const BoxDecoration(color: Colors.black),
        child: GetBuilder<SharedResourcesController>(
          builder: (_) => sharedResourcesController.postFor == PostFor.alcohol
              ? AlcoholPostCreationWidget()
              : ClothsPostCreationScreen(),
        ),
      ),
    ),
  );
}
