import 'package:ensa/models/user_model.dart';

class Story {
  final User user;
  final List<String> images;

  const Story({
    required this.user,
    required this.images,
  });
}
