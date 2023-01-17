import 'package:ensa/graphql/graphql_api.dart';
import 'package:ensa/models/post_model.dart';
import 'package:ensa/utils/types/uploaded_media_file.dart';
import 'package:ensa/widgets/posts/post_media_item_widget.dart';
import 'package:flutter/material.dart';

class PostMedia extends StatelessWidget {
  PostMedia(this.post, {Key? key}) : super(key: key);

  final FeedPostMixin post;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260.0,
      child: PageView(
        physics: BouncingScrollPhysics(),
        children: [
          ...post.files
              .map(
                (e) => PostMediaItem(e),
              )
              .toList(),
        ],
      ),
    );
  }
}
