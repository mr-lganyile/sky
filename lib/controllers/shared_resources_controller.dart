import 'package:get/get.dart';

enum PostFor { alcohol, clothing }

class SharedResourcesController extends GetxController {
  SharedResourcesController();

  // ignore: prefer_final_fields
  Rx<PostFor> _postFor = Rx(PostFor.clothing);
  PostFor get postFor => _postFor.value;

  // ignore: prefer_final_fields
  Rx<bool> _showProgressBar = Rx(false);
  bool get showProgressBar => _showProgressBar.value;

  // ignore: prefer_final_fields
  Rx<bool> _showLoginProgressBar = Rx(false);
  bool get showLoginProgressBar => _showLoginProgressBar.value;

  // ignore: prefer_final_fields
  Rx<bool> _showSigninProgressBar = Rx(false);
  bool get showSigninProgressBar => _showSigninProgressBar.value;

  // ignore: prefer_final_fields
  Rx<bool> _showPhoneVerificationProgressBar = Rx(false);
  bool get showPhoneVerificationProgressBar =>
      _showPhoneVerificationProgressBar.value;

  // ignore: prefer_final_fields
  Rx<bool> _showPasswordVerificationProgressBar = Rx(false);
  bool get showPasswordVerificationProgressBar =>
      _showPasswordVerificationProgressBar.value;

  // ignore: prefer_final_fields
  Rx<bool> _isLeaderValidated = Rx(false);
  bool get isLeaderValidated => _isLeaderValidated.value;

  static SharedResourcesController sharedResourcesController = Get.find();

  void setPostFor(PostFor postFor) {
    _postFor = Rx(postFor);
    update();
  }

  void setShowProgressBar(bool showProgressBar) {
    _showProgressBar = Rx(showProgressBar);
    update();
  }

  void setShowLoginProgressBar(bool showProgressBar) {
    _showLoginProgressBar = Rx(showProgressBar);
    update();
  }

  void setShowSigninProgressBar(bool showProgressBar) {
    _showSigninProgressBar = Rx(showProgressBar);
    update();
  }

  void setShowPhoneVerificationProgressBar(bool showProgressBar) {
    _showPhoneVerificationProgressBar = Rx(showProgressBar);
    update();
  }

  void setShowPasswordVerificationProgressBar(bool showProgressBar) {
    _showPasswordVerificationProgressBar = Rx(showProgressBar);
    update();
  }

  void setIsLeaderValidated(bool isLeaderValidated) {
    _isLeaderValidated = Rx(isLeaderValidated);
    update();
  }
}
