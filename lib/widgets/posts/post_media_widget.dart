import 'package:ensa/graphql/graphql_api.dart';
import 'package:ensa/models/post_model.dart';
import 'package:ensa/widgets/posts/post_media_item_widget.dart';
import 'package:flutter/material.dart';

class PostMedia extends StatelessWidget {
  PostMedia(this.post, {Key? key}) : super(key: key);

  final FeedPostMixin post;

  int get _mediaCount => post.files.length;

  @override
  Widget build(BuildContext context) {
    if (_mediaCount > 1) {
      return Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: 260.0,
            child: PageView(
              physics: BouncingScrollPhysics(),
              children: [
                ...post.files
                    .map((e) => PostMediaItem(
                          e,
                          mediaType: MediaType.IMAGE,
                        ))
                    .toList(),
              ],
            ),
          ),
        ],
      );
    }
    if (_mediaCount == 1)
      return PostMediaItem(
        post.files[0],
        mediaType: MediaType.IMAGE,
      );

    return Container();
  }
}
