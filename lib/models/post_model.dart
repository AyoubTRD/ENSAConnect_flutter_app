import 'package:ensa/models/user_model.dart';

class Post {
  Post({
    required this.id,
    required this.user,
    this.content,
    required this.images,
    required this.videos,
    required this.videoThumbnails,
    required this.createdAt,
    required this.commentsCount,
    required this.reactionsCount,
    required this.isBookmarked,
    required this.isLiked,
  });

  final String id;
  final User user;
  final String? content;
  final List<String> images;
  final List<String> videos;
  final List<String> videoThumbnails;
  final String createdAt;
  int commentsCount;
  int reactionsCount;
  bool isBookmarked;
  bool isLiked;
}
