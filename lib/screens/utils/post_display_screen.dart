import 'package:get/get.dart';
import '../alcohol/alcohol_post_display_screen.dart';
import '../clothing/clothing_post_display_screen.dart';
import '../../controllers/user_controller.dart';
import '../../controllers/shared_resources_controller.dart';

import '../authentication/user_registration_widget.dart';
import 'globals.dart';

import 'package:flutter/material.dart';

import '../../main.dart';

import '../authentication/login_widget.dart';
import '../alcohol/alcohol_post_creation_widget.dart';
import 'post_creation_widget.dart';

// Branch : won_price_summary_resources_crud -> view_won_price_summaries
class PostDisplayScreen extends StatelessWidget {
  PostDisplayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double listTilesFontSize = 15;
    double listTilesIconSize = 30;

    return Scaffold(
      drawer: Drawer(
        width: MediaQuery.of(context).size.width * 0.5,
        backgroundColor: Colors.black.withOpacity(0.9),
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.info, size: listTilesIconSize),
              iconColor: MyApplication.logoColor1,
              textColor: MyApplication.logoColor2,
              title: Text(
                'About',
                style: TextStyle(fontSize: listTilesFontSize),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => const AboutDialog(
                    applicationIcon: CircleAvatar(
                      backgroundImage: AssetImage('assets/logo.png'),
                    ),
                    applicationLegalese: 'Lealese',
                    applicationName: 'Alco',
                    applicationVersion: 'version 1.0.0',
                    children: [Text('Cheers!!!')],
                  ),
                );
              },
            ),
            /*
            ListTile(
              leading: Icon(
                Icons.admin_panel_settings,
                size: listTilesIconSize,
              ),
              iconColor: MyApplication.logoColor1,
              textColor: MyApplication.logoColor2,
              title: Text(
                'Admin',
                style: TextStyle(fontSize: listTilesFontSize),
              ),
              onTap: () => Get.to(() => AdminEntranceWidget()),
            ),

            ListTile(
              leading: Icon(Icons.location_searching, size: listTilesIconSize),
              iconColor: MyApplication.logoColor1,
              textColor: MyApplication.logoColor2,
              title: Text(
                'Areas',
                style: TextStyle(fontSize: listTilesFontSize),
              ),
              onTap: () {},
            ),
            
            ListTile(
              leading: Icon(Icons.group, size: listTilesIconSize),
              iconColor: MyApplication.logoColor1,
              textColor: MyApplication.logoColor2,
              title: Text(
                'Users',
                style: TextStyle(fontSize: listTilesFontSize),
              ),
              onTap: () => Get.to(() => UsersWidget()),
            ), */
            ListTile(
              leading: Icon(Icons.post_add, size: listTilesIconSize),
              iconColor: MyApplication.logoColor1,
              textColor: MyApplication.logoColor2,
              title: Text(
                'Post',
                style: TextStyle(fontSize: listTilesFontSize),
              ),
              onTap: () => Get.to(
                () => getCurrentlyLoggenInUser() == null
                    ? UserRegistrationWidget()
                    : PostCreationWidget(),
              ),
            ),
            getCurrentlyLoggenInUser() != null
                ? const SizedBox.shrink()
                : ListTile(
                    leading: Icon(
                      Icons.account_circle,
                      size: listTilesIconSize,
                    ),
                    iconColor: MyApplication.logoColor1,
                    textColor: MyApplication.logoColor2,
                    title: Text(
                      'Join',
                      style: TextStyle(fontSize: listTilesFontSize),
                    ),
                    onTap: () {
                      sharedResourcesController.setShowSigninProgressBar(false);
                      sharedResourcesController
                          .setShowPhoneVerificationProgressBar(false);
                      Get.to(() => UserRegistrationWidget());
                    },
                  ),
            const Divider(height: 5),
            GetBuilder<UserController>(
              builder: (_) {
                return ListTile(
                  leading: Icon(
                    getCurrentlyLoggenInUser() != null
                        ? Icons.logout
                        : Icons.login,
                    size: listTilesIconSize,
                  ),
                  iconColor: MyApplication.logoColor1,
                  textColor: MyApplication.logoColor2,
                  title: Text(
                    getCurrentlyLoggenInUser() != null ? 'Logout' : 'Login',
                    style: TextStyle(fontSize: listTilesFontSize),
                  ),
                  onTap: () {
                    if (getCurrentlyLoggenInUser() != null) {
                      logoutUser();
                      getSnapbar(
                        'Notification',
                        'You Have Logged Out Successfully.',
                      );
                      Get.close(1);
                    } else {
                      Get.to(() => LoginWidget());
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
      backgroundColor: MyApplication.scaffoldColor,
      appBar: AppBar(
        backgroundColor: MyApplication.scaffoldColor,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              iconSize: blueIconsSize,
              color: MyApplication.logoColor2,
              onPressed: (() {
                Scaffold.of(context).openDrawer();
              }),
            );
          },
        ),
        title: Text(
          "Posts",
          style: TextStyle(
            fontSize: MyApplication.infoTextFontSize,
            color: MyApplication.attractiveColor1,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        actions: [popupMenuButton()],
      ),
      body: Container(
        // height: 300,
        decoration: BoxDecoration(
          color: MyApplication.scaffoldColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: GetBuilder<SharedResourcesController>(
          builder: (_) => sharedResourcesController.postFor == PostFor.alcohol
              ? AlcoholPostDisplayScreen()
              : ClothingPostDisplayScreen(),
        ),
      ),
    );
  }
}
