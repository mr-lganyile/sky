import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/alcohol_post_controller.dart';
import '../../controllers/user_controller.dart';
import '../../main.dart';
import '../../models/posts/post_comment.dart';
import '../authentication/user_registration_widget.dart';

import 'dart:developer' as debug;

import '../utils/globals.dart';
import '../utils/post_comment_widget.dart';

class AlcoholPostCommentsWidgets extends StatelessWidget {
  String postFK;
  final AlcoholPostController postController =
      AlcoholPostController.alcoholPostController;
  final UserController userController = UserController.userController;
  late List<PostComment> comments;

  AlcoholPostCommentsWidgets({Key? key, required this.postFK})
    : super(key: key);

  Widget retrieveCommentTextField(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return TextField(
      maxLines: 10,
      minLines: 1,
      style: TextStyle(color: MyApplication.scaffoldBodyColor),
      cursorColor: MyApplication.scaffoldBodyColor,
      controller: controller,
      decoration: InputDecoration(
        labelText: 'Write Your Comment',
        helperMaxLines: 10,
        prefixIcon: Icon(Icons.comment, color: MyApplication.logoColor1),
        suffixIcon: GestureDetector(
          child: Icon(Icons.send, color: MyApplication.logoColor1),
          onTap: () {
            // Save Comment
            if (userController.currentlyLoggedInUser == null) {
              Get.to(() => UserRegistrationWidget());
            } else {
              postController.saveAlcoholPostComment(postFK, controller.text);
              controller.clear();
            }
          },
        ),
        labelStyle: TextStyle(fontSize: 14, color: MyApplication.logoColor2),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: MyApplication.logoColor2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: MyApplication.logoColor2),
        ),
      ),
      obscureText: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Comments',
          style: TextStyle(
            fontSize: MyApplication.infoTextFontSize,
            color: MyApplication.attractiveColor1,
          ),
        ),
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          iconSize: 20,
          color: MyApplication.logoColor2,
          onPressed: (() {
            Get.back();
          }),
        ),
        elevation: 0,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: StreamBuilder<List<PostComment>>(
              stream: postController.readAlcoholPostComments(postFK),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  comments = snapshot.data!;
                  return ListView.builder(
                    itemCount: comments.length,
                    itemBuilder: ((context, index) =>
                        PostCommentWidget(postComment: comments[index])),
                  );
                } else if (snapshot.hasError) {
                  return getCircularProgressBar();
                } else {
                  return getCircularProgressBar();
                }
              },
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 80,
                margin: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                child: SizedBox(
                  height: 65,
                  child: retrieveCommentTextField(context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
