import 'package:ensa/models/post_model.dart';
import 'package:ensa/models/user_model.dart';

enum NotificationType {
  FRIEND_REQUEST,
  FRIEND_REQUEST_ACCEPTED,
  NEW_POST,
  POST_LIKED,
  NEW_COMMENT,
  COMMENT_REPLY,
  COMMENT_LIKED,
}

class AppNotification {
  const AppNotification(
      {required this.id, required this.type, this.user, this.post});

  final String id;
  final NotificationType type;
  final User? user;
  final Post? post;
  // final Comment? comment;

}
