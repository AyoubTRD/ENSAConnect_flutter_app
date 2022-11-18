import 'package:ensa/utils/constants.dart';
import 'package:flutter/material.dart';

enum MediaType { IMAGE, VIDEO }

class PostMediaItem extends StatefulWidget {
  const PostMediaItem(this.url, {Key? key, required this.mediaType})
      : super(key: key);

  final String url;
  final MediaType mediaType;

  @override
  _PostMediaItemState createState() => _PostMediaItemState();
}

class _PostMediaItemState extends State<PostMediaItem> {
  @override
  Widget build(BuildContext context) {
    return Image.network(
      widget.url,
      height: 260.0,
      width: MediaQuery.of(context).size.width - kDefaultPadding,
      fit: BoxFit.cover,
    );
  }
}
