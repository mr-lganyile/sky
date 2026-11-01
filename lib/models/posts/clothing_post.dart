import 'package:sky/models/posts/clothing.dart';

import '../users/user.dart' as my;
import '/models/posts/post.dart';

class ClothingPost extends Post implements Comparable<ClothingPost> {
  Clothing clothing;

  ClothingPost({
    required this.clothing,
    required String postId,
    required my.User postCreator,
    DateTime? dateCreated,
    required String forTownOrInstitutionNo,
  }) : super(
         postId: postId,
         postCreator: postCreator,
         dateCreated: dateCreated,
         forTownOrInstitutionNo: forTownOrInstitutionNo,
       );

  Map<String, dynamic> toJson() => {
    'postId': postId,
    'postCreator': postCreator.toJson(),
    'forTownOrInstitutionNo': forTownOrInstitutionNo,
    'clothing': clothing.toJson(),
    'dateCreated': {},
  };

  factory ClothingPost.fromJson(dynamic json) => ClothingPost(
    clothing: Clothing.fromJson(json['clothing']),
    postId: json['postId'],
    postCreator: my.User.fromJson(json['postCreator']),
    dateCreated: DateTime(
      json['dateCreated']['year'],
      json['dateCreated']['month'],
      json['dateCreated']['date'],
      json['dateCreated']['hour'],
      json['dateCreated']['minute'],
    ),
    forTownOrInstitutionNo: json['forTownOrInstitutionNo'],
  );

  @override
  int compareTo(ClothingPost other) {
    return other.dateCreated!.compareTo(dateCreated!);
  }
}
