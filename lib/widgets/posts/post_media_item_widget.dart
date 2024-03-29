import 'package:ensa/graphql/graphql_api.dart';
import 'package:ensa/utils/constants.dart';
import 'package:ensa/utils/types/uploaded_media_file.dart';
import 'package:ensa/widgets/core/utility/play_button_widget.dart';
import 'package:flutter/material.dart';

class PostMediaItem extends StatefulWidget {
  const PostMediaItem(this.file, {Key? key}) : super(key: key);

  final MediaFileMixin file;

  @override
  _PostMediaItemState createState() => _PostMediaItemState();
}

class _PostMediaItemState extends State<PostMediaItem> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          widget.file.fileType == MediaFileType.image
              ? widget.file.filePath
              : widget.file.thumbnailPath!,
          height: 260.0,
          width: MediaQuery.of(context).size.width - kDefaultPadding,
          fit: BoxFit.cover,
        ),
        if (widget.file.fileType == MediaFileType.video)
          Align(
            alignment: Alignment.center,
            child: PlayButton(
              size: 64.0,
            ),
          )
      ],
    );
  }
}
