import 'package:ensa/models/post_model.dart';
import 'package:ensa/widgets/post_media_item_widget.dart';
import 'package:flutter/material.dart';

class PostMedia extends StatelessWidget {
  PostMedia(this.post, {Key? key}) : super(key: key);

  final Post post;

  int get _mediaCount => post.images.length + post.videos.length;

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
                ...post.videoThumbnails
                    .map((e) => PostMediaItem(
                          e,
                          mediaType: MediaType.VIDEO,
                        ))
                    .toList(),
                ...post.images
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
    if (post.videos.isNotEmpty) {
      return PostMediaItem(
        post.videos[0],
        mediaType: MediaType.VIDEO,
      );
    }
    return PostMediaItem(
      post.images[0],
      mediaType: MediaType.IMAGE,
    );
  }
}
