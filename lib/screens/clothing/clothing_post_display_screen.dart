import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/clothing_post_controller.dart';
import '../../controllers/shared_resources_controller.dart';
import '../../main.dart';
import '../../models/posts/clothing_post.dart';
import '../../models/users/abstract_user.dart';
import '../utils/globals.dart'
    show getCircularProgressBar, getCurrentlyLoggenInUser;
import 'clothing_post_comments_widget.dart';
import 'single_clothing_post_widget.dart';
import 'dart:developer' as debug;
import '../../models/users/user.dart' as my;

class ClothingPostDisplayScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ClothingPostDisplayScreenState();
}

class ClothingPostDisplayScreenState extends State<ClothingPostDisplayScreen> {
  ClothingPostController postController =
      ClothingPostController.clothingPostController;
  late Stream<List<ClothingPost>> postsStream;
  SharedResourcesController sharedResourcesController =
      SharedResourcesController.sharedResourcesController;

  // Widget ready for close testing.
  @override
  Widget build(BuildContext context) {
    AbstractUser? user = getCurrentlyLoggenInUser();

    if (user == null) {
      postsStream = postController.readAreaClothingPosts("7"); // durban central
    } else {
      postsStream = postController.readAreaClothingPosts(
        (user as my.User).area.townOrInstitutionFK,
      );
    }
    return StreamBuilder<List<ClothingPost>>(
      stream: postsStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<ClothingPost> posts = snapshot.data!;
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: ((context, index) {
              return Column(
                children: [
                  SingleClothingPostWidget(post: posts[index]),
                  Container(
                    margin: const EdgeInsets.only(right: 15),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: () {
                          Get.to(
                            () => ClothingPostCommentsWidget(
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
