import 'package:get/get.dart';

import '../../controllers/alcohol_post_controller.dart';
import '../../models/posts/alcohol_post.dart';
import '../../models/users/abstract_user.dart';
import '../utils/globals.dart';

import 'package:flutter/material.dart';

import '../../main.dart';

import 'dart:developer' as debug;
import '../../models/users/user.dart' as my;

import 'alcohol_post_comments_widget.dart';
import 'single_alcohol_post_widget.dart';

// Branch : won_price_summary_resources_crud -> view_won_price_summaries
class AlcoholPostDisplayScreen extends StatelessWidget {
  AlcoholPostDisplayScreen({super.key});

  AlcoholPostController postController =
      AlcoholPostController.alcoholPostController;
  late Stream<List<AlcoholPost>> postsStream;

  @override
  Widget build(BuildContext context) {
    AbstractUser? user = getCurrentlyLoggenInUser();

    if (user == null) {
      postsStream = postController.readAreaAlcoholPosts("7"); // durban central
    } else {
      postsStream = postController.readAreaAlcoholPosts(
        (user as my.User).area.townOrInstitutionFK,
      );
    }
    return StreamBuilder<List<AlcoholPost>>(
      stream: postsStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<AlcoholPost> posts = snapshot.data!;
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: ((context, index) {
              return Column(
                children: [
                  SingleAlcoholPostWidget(post: posts[index]),
                  Container(
                    margin: const EdgeInsets.only(right: 15),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: () {
                          Get.to(
                            () => AlcoholPostCommentsWidgets(
                              postFK: posts[index].postId,
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.message,
                          size: 30,
                          color: MyApplication.logoColor1,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
          );
        } else if (snapshot.hasError) {
          debug.log("Error Fetching Past Post Data *** - ${snapshot.error}");
          return getCircularProgressBar();
        } else {
          return getCircularProgressBar();
        }
      },
    );
  }
}
