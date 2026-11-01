import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../models/posts/trackable.dart';

import '../models/converter.dart';
import '../models/locations/town_or_institution.dart';
import '../models/posts/clothing.dart';
import '../models/posts/clothing_post.dart';
import '../models/posts/identifeir_symbol.dart';
import '../models/posts/identifeir_symbol_position.dart';
import '../models/posts/post_comment.dart';
import '../models/users/abstract_user.dart';
import '../models/users/user.dart' as my;
import '../screens/utils/globals.dart';

enum ClothingPostStatus {
  loginRequired,
  noClothingImage,
  noClothingIdentified,
  postSaved,
}

enum TrackableUpdateStatus {
  ignored,
  huged,
  phoneNumberRequested,
  liked,
  disliked,
}

class ClothingPostController extends GetxController {
  static ClothingPostController clothingPostController = Get.find();
  FirebaseFirestore firestore;
  FirebaseFunctions functions;
  Reference storage;
  FirebaseAuth auth;

  Rx<DocumentReference?> _clothingPostReference = Rx(null);
  DocumentReference? get clothingPostReference => _clothingPostReference.value;
  String? host;

  ClothingPostController({
    required this.firestore,
    required this.storage,
    required this.functions,
    required this.auth,
  });

  // ======================Cloths Post [Start]======================
  /*Rx<String> _clothsPostImageURL = Rx('');
  String get clothsPostImageURL => _clothsPostImageURL.value; 

  Rx<File?> _clothsPostImage = Rx(null);
  File? get clothsPostImage => _clothsPostImage.value;*/

  Rx<List<IdentifeirSymbolPosition>> _gridPositions = Rx([]);
  List<IdentifeirSymbolPosition> get gridPositions => _gridPositions.value;

  Rx<Set<int>> _alreadyPlacedIdentifeirSymbolsIndices = Rx({});
  Set<int> get alreadyPlacedIdentifeirSymbolsIndices =>
      _alreadyPlacedIdentifeirSymbolsIndices.value;

  static int maximumNumberOfPositions = -1;

  Rx<bool> _allowMovementOfDraggable = Rx(true);
  bool get allowMovementOfDraggable => _allowMovementOfDraggable.value;

  Rx<Clothing> _clothing = Rx(Clothing(identifierSymbols: {}));
  Clothing get clothing => _clothing.value;

  Rx<IdentifeirSymbol?> _currentIdentifeirSymbol = Rx(null);
  IdentifeirSymbol? get currentIdentifeirSymbol =>
      _currentIdentifeirSymbol.value;

  Future<TrackableUpdateStatus> updateTrackableQuantify(
    String postId,
    int identifeirIndex,
    Trackable trackable,
    bool increase,
  ) async {
    TrackableUpdateStatus result;
    setClothingPostReference();

    DocumentReference reference = firestore
        .collection('clothing_posts')
        .doc(postId);

    String data;

    switch (trackable) {
      case Trackable.numberOfLikes:
        data = 'clothing[identifierSymbols][$identifeirIndex][numberOfLikes]';
        result = TrackableUpdateStatus.liked;
        break;
      case Trackable.numberOfDislikes:
        data =
            'clothing[identifierSymbols][$identifeirIndex][numberOfDislikes]';
        result = TrackableUpdateStatus.disliked;
        break;
      case Trackable.numberOfHugs:
        data = 'clothing[identifierSymbols][$identifeirIndex][numberOfHugs]';
        result = TrackableUpdateStatus.huged;
        break;
      case Trackable.numberOfIgnores:
        data = 'clothing[identifierSymbols][$identifeirIndex][numberOfIgnores]';
        result = TrackableUpdateStatus.ignored;
        break;
      default:
        data =
            'clothing[identifierSymbols][$identifeirIndex][numberOfPhoneNumberRequests]';
        result = TrackableUpdateStatus.phoneNumberRequested;
    }

    reference.update({
      data: increase ? FieldValue.increment(1) : FieldValue.increment(-1),
    });
    return result;
  }

  void setClothingPostReference() {
    if (_clothingPostReference.value == null) {
      _clothingPostReference = Rx(firestore.collection('clothing_posts').doc());
    }
  }

  void clearClothingPostReference() {
    if (_clothingPostReference.value != null) {
      _clothingPostReference = Rx(null);
    }
  }

  void setCurrentIdentifeirSymbol(IdentifeirSymbol? identifeirSymbol) {
    _currentIdentifeirSymbol = Rx(identifeirSymbol);
  }

  void addClothing() {
    if (currentIdentifeirSymbol != null) {
      clothing.addClothing(currentIdentifeirSymbol!);
    }
  }

  void clearForNewClothing() {
    _currentIdentifeirSymbol = Rx(null);
    _clothing = Rx(Clothing(identifierSymbols: {}));
    _alreadyPlacedIdentifeirSymbolsIndices = Rx({});
    maximumNumberOfPositions = -1;
    _gridPositions = Rx([]);
    update();
  }

  void updateAllowMovementOfDraggable(bool allowMovement) =>
      _allowMovementOfDraggable = Rx(allowMovement);

  bool canAddOnGridPosition(int atPosition) =>
      _gridPositions.value[atPosition].identifeirSymbol == null;

  void captureClothsPostImage() async {
    AbstractUser? user = getCurrentlyLoggenInUser();
    if (user == null) {
      Get.snackbar('Error', 'Error Login Required');
    } else {
      final pickedImageFile = await ImagePicker().pickImage(
        source: ImageSource.camera,
      );

      if (pickedImageFile != null) {
        Rx<File?> clothsPostImage = Rx<File?>(File(pickedImageFile.path));

        my.User alcoholic = user as my.User;
        host = Converter.townOrInstitutionAsString(
          Converter.toSupportedTownOrInstitution(
            alcoholic.area.sectionName,
          ).townOrInstitutionName,
        ).toLowerCase();

        setClothingPostReference();

        String clothsPostImageURL = Rx<String>(
          await uploadResource(
            clothsPostImage.value!,
            '$host/clothing_posts/${_clothingPostReference.value!.id}',
          ),
        ).value;
        clothing.setClothsPostImageURL(trimmedURL(clothsPostImageURL));

        // Get.snackbar('Image Status', 'Image File Successfully Captured.');
        update();
      } else {
        Get.snackbar('Error', 'Image Wasn\'t Captured.');
      }
    }
  }

  void chooseClothsPostImageFromGallery() async {
    AbstractUser? user = getCurrentlyLoggenInUser();
    if (user == null) {
      Get.snackbar('Error', 'Error Login Required');
    } else {
      final pickedImageFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );

      if (pickedImageFile != null) {
        Rx<File?> clothsPostImage = Rx<File?>(File(pickedImageFile.path));

        my.User alcoholic = user as my.User;
        host = Converter.townOrInstitutionAsString(
          Converter.toSupportedTownOrInstitution(
            alcoholic.area.sectionName,
          ).townOrInstitutionName,
        ).toLowerCase();

        setClothingPostReference();

        String clothsPostImageURL = Rx<String>(
          await uploadResource(
            clothsPostImage.value!,
            '$host/clothing_posts/${_clothingPostReference.value!.id}',
          ),
        ).value;
        clothing.setClothsPostImageURL(trimmedURL(clothsPostImageURL));

        // Get.snackbar('Image Status', 'Image File Successfully Captured.');
        update();
      } else {
        Get.snackbar('Error', 'Image Wasn\'t Captured.');
      }
    }
  }

  void updateGridPositions(int atPosition, IdentifeirSymbol identifeirSymbol) {
    gridPositions[atPosition].setIdentifeirSymbol(identifeirSymbol);
    update();
  }

  void updateAlreadyPlacedIdentifeirSymbolsIndices(int index) {
    if (_alreadyPlacedIdentifeirSymbolsIndices.value.contains(index)) {
      _alreadyPlacedIdentifeirSymbolsIndices.value.remove(index);
    } else {
      _alreadyPlacedIdentifeirSymbolsIndices.value.add(index);
    }
    update();
  }

  bool isIndexUsed(int index) {
    return _alreadyPlacedIdentifeirSymbolsIndices.value.contains(index);
  }

  static void increaseMaximumNumberOfPositions() {
    maximumNumberOfPositions++;
  }

  void removeIdentifierSymbolFromGridPosition(int identifeirIndex) {
    for (IdentifeirSymbolPosition position in gridPositions) {
      if (position.identifeirSymbol != null &&
          position.identifeirSymbol!.identifeirIndex == identifeirIndex) {
        position.setIdentifeirSymbol(null);
        alreadyPlacedIdentifeirSymbolsIndices.remove(identifeirIndex);
      }
    }
    update();
  }

  Stream<List<ClothingPost>> readAllClothingPosts()
  /*=> Stream.value([
    ClothingPost(
      dateCreated: DateTime.now(),
      clothing: Clothing(
        identifierSymbols: {
          0: IdentifeirSymbol(
            clothingName: 'Hugo Boss',
            identifeirIndex: 0,
            clothingPrice: 5760,
          ),
          1: IdentifeirSymbol(clothingName: 'Ray Bal', identifeirIndex: 1),
          2: IdentifeirSymbol(
            clothingName: 'Desiel',
            identifeirIndex: 0,
            clothingPrice: 6750,
          ),
        },
      ),
      postId: 'postId',
      postCreator: my.User(
        userId: 'userid',
        phoneNumber: '+27854342345',
        profileImageURL: 'assets/logo.png',
        area: SupportedArea(),
        username: 'nkuxa',
        password: 'password',
      ),
    ),
  ]);*/
  => firestore.collection('clothing_posts').snapshots().map((postsSnapshot) {
    List<ClothingPost> list = postsSnapshot.docs.map((postDoc) {
      ClothingPost post = ClothingPost.fromJson(postDoc.data());
      return post;
    }).toList();
    list.sort();

    return list;
  });

  Stream<List<ClothingPost>> readAreaClothingPosts(
    String forTownOrInstitutionNo,
  ) /*=> Stream.value([
    ClothingPost(
      dateCreated: DateTime(2026, 9, 29, 8, 30),
      clothing: Clothing(
        identifierSymbols: {
          0: IdentifeirSymbol(clothingName: 'armani code', identifeirIndex: 5),
        },
      ),
      postId: 'post_pub',
      postCreator: my.User(
        userId: 'user_cup',
        phoneNumber: '+27839809009',
        profileImageURL: '../images/image.png',
        area: SupportedArea(),
        username: 'zangume',
        password: 'yebo',
      ),
    ),
    ClothingPost(
      dateCreated: DateTime.now(),
      clothing: Clothing(
        identifierSymbols: {
          0: IdentifeirSymbol(
            clothingName: 'Lacoste',
            identifeirIndex: 0,
            clothingPrice: 4500,
          ),
          1: IdentifeirSymbol(clothingName: 'Gucci', identifeirIndex: 4),
        },
      ),
      postId: 'post_234',
      postCreator: my.User(
        userId: 'user_opq',
        phoneNumber: '+27839809876',
        profileImageURL: '../images/image.png',
        area: SupportedArea(),
        username: 'mthole',
        password: 'pmb',
      ),
    ),
    ClothingPost(
      dateCreated: DateTime.now(),
      clothing: Clothing(
        identifierSymbols: {
          0: IdentifeirSymbol(
            clothingName: 'Hugo Boss',
            identifeirIndex: 0,
            clothingPrice: 5760,
          ),
          1: IdentifeirSymbol(clothingName: 'Ray Bal', identifeirIndex: 1),
          2: IdentifeirSymbol(
            clothingName: 'Desiel',
            identifeirIndex: 0,
            clothingPrice: 6750,
          ),
        },
      ),
      postId: 'postId',
      postCreator: my.User(
        userId: 'userid',
        phoneNumber: '+27854342345',
        profileImageURL: 'assets/logo.png',
        area: SupportedArea(),
        username: 'nkuxa',
        password: 'password',
      ),
    ),
  ]); */ => firestore
      .collection('clothing_posts')
      .where('forTownOrInstitutionNo', isEqualTo: forTownOrInstitutionNo)
      .snapshots()
      .map((postsSnapshot) {
        List<ClothingPost> list = postsSnapshot.docs.map((postDoc) {
          ClothingPost post = ClothingPost.fromJson(postDoc.data());
          return post;
        }).toList();
        list.sort();

        return list;
      });

  Future<ClothingPostStatus> saveClothingPost() async {
    AbstractUser? user = getCurrentlyLoggenInUser();

    if (user == null) {
      return ClothingPostStatus.loginRequired;
    } else if (clothing.clothsPostImageURL!.isEmpty) {
      return ClothingPostStatus.noClothingImage;
    } else if (!clothing.hasIdentifiedAtleastOneClothing()) {
      return ClothingPostStatus.noClothingIdentified;
    } else {
      setClothingPostReference();

      if (host == null) {
        my.User? alcoholic = getCurrentlyLoggenInUser() as my.User;

        host = Converter.townOrInstitutionAsString(
          Converter.toSupportedTownOrInstitution(
            alcoholic.area.sectionName,
          ).townOrInstitutionName,
        ).toLowerCase();
      }

      // FieldValue.serverTimestamp();
      ClothingPost clothingPost = ClothingPost(
        clothing: clothing,
        postId: clothingPostReference!.id,
        postCreator: user as my.User,
        forTownOrInstitutionNo:
            '${Converter.townOrInstitutionAsNumber(Converter.toTownOrInstitution(host!))}',
      );

      await _clothingPostReference.value!.set(clothingPost.toJson());
      clearClothingPostReference();

      return ClothingPostStatus.postSaved;
    }
  }

  Future<void> saveClothingPostComment(String postFK, String message) async {
    AbstractUser? user = getCurrentlyLoggenInUser();

    if (user == null) {
      getSnapbar('Unauthorized Action', 'Login Before Commenting');
      return;
    }
    TownOrInstitution townOrInstitution;
    townOrInstitution = Converter.toSupportedTownOrInstitution(
      (user as my.User).area.sectionName,
    ).townOrInstitutionName;

    DocumentReference postRef = firestore
        .collection('clothing_posts')
        .doc(postFK);

    postRef.get().then((postDoc) async {
      if (postDoc.exists) {
        ClothingPost post = ClothingPost.fromJson(postDoc.data());

        int one = int.parse(post.postCreator.area.townOrInstitutionFK);
        int two = int.parse(
          userController.currentlyLoggedInUser!.area.townOrInstitutionFK,
        );
        bool result = one == two;

        if (result) {
          DocumentReference commentReference = postRef
              .collection('comments')
              .doc();
          PostComment? comment;
          if (userController.currentlyLoggedInUser != null) {
            comment = PostComment(
              postCommentId: commentReference.id,
              forTownOrInstitution: townOrInstitution,
              postFK: postFK,
              message: message,
              imageURL: userController.currentlyLoggedInUser!.profileImageURL,
              username: userController.currentlyLoggedInUser!.username,
            );
          }

          await commentReference.set(comment!.toJson());
        } else {
          String host = Converter.townOrInstitutionAsString(
            Converter.toSupportedTownOrInstitution(
              post.postCreator.area.sectionName,
            ).townOrInstitutionName,
          );
          ;
          Get.snackbar('Error', 'Only $host Users May Comment.');
        }
      }
    });
  }

  Stream<List<PostComment>> readClothingPostComments(String postFK) => firestore
      .collection('clothing_posts')
      .doc(postFK)
      .collection('comments')
      .snapshots()
      .map((commentsSnapshot) {
        List<PostComment> list = commentsSnapshot.docs.map((commentDoc) {
          PostComment comment = PostComment.fromJson(commentDoc.data());
          return comment;
        }).toList();
        list.sort();
        return list;
      });

  // ======================Cloths Post [End]======================
}
