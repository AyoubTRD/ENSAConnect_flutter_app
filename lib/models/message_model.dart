import 'package:ensa/models/user_model.dart';

class Message {
  final String id;
  final User user;
  final String text;
  final String createdAt;

  Message({
    required this.id,
    required this.user,
    required this.text,
    required this.createdAt,
  });
}
