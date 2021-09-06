import 'package:ensa/models/message_model.dart';
import 'package:ensa/models/user_model.dart';

class Chat {
  final String id;
  final List<User> users;
  final List<Message> messages;

  Chat({required this.id, required this.users, required this.messages});
}
