import '../users/user.dart' as my;

class Post {
  String postId;
  my.User postCreator;
  DateTime? dateCreated;
  late String? forTownOrInstitutionNo;

  Post({
    required this.postId,
    required this.postCreator,
    this.dateCreated,
    this.forTownOrInstitutionNo,
  });

  String passedTimeRepresentation() {
    Duration duration = dateCreated!.difference(DateTime.now());

    String passedTimeRepresentation;
    if (duration.inMinutes.abs() <= 1) {
      passedTimeRepresentation = 'now';
    } else if (duration.inMinutes.abs() <= 59) {
      passedTimeRepresentation = '${duration.inMinutes.abs()}mins';
    } else if (duration.inHours.abs() < 2) {
      passedTimeRepresentation = '1h';
    } else if (duration.inHours.abs() < 24) {
      passedTimeRepresentation = '${duration.inHours.abs()}h';
    } else if (duration.inDays.abs() < 7) {
      passedTimeRepresentation = '${duration.inDays.abs()}d';
    } else if (duration.inDays.abs() < 28) {
      passedTimeRepresentation = '${duration.inDays.abs() ~/ 7}w';
    } else if (duration.inDays.abs() < 365) {
      passedTimeRepresentation = '${duration.inDays.abs() ~/ 30}mo';
    } else if (duration.inDays.abs() < 365 * 2) {
      passedTimeRepresentation = '1yr';
    } else {
      passedTimeRepresentation = '${duration.inDays.abs() ~/ 365}yrs';
    }

    return passedTimeRepresentation;
  }
}
