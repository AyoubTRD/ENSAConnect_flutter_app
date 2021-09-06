import 'package:ensa/utils/constants.dart';
import 'package:ensa/widgets/post_widget.dart';
import 'package:flutter/material.dart';

class Posts extends StatelessWidget {
  const Posts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: kPosts
          .map(
            (e) => FeedPost(
              e,
              key: Key(e.id),
            ),
          )
          .toList(),
    );
  }
}
