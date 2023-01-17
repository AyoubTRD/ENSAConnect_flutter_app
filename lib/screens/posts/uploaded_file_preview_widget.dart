import 'package:ensa/graphql/graphql_api.dart';
import 'package:ensa/utils/types/uploaded_media_file.dart';
import 'package:ensa/widgets/core/utility/play_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class UploadedFilePreview extends StatelessWidget {
  static final uploadedFilePreviewHeight = 120.0;

  const UploadedFilePreview(this.file, {this.onRemove, Key? key})
      : super(key: key);

  final UploadedMediaFile file;
  final void Function()? onRemove;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: uploadedFilePreviewHeight,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: AnimatedOpacity(
            opacity: file.isUploading ? 0.6 : 1,
            duration: const Duration(milliseconds: 450),
            curve: Curves.easeInOut,
            child: SizedBox(
              height: uploadedFilePreviewHeight,
              child: file.bytes == null
                  ? Image.network(
                      file.path!,
                      fit: BoxFit.fitHeight,
                    )
                  : Image.memory(
                      file.bytes!,
                      fit: BoxFit.fitHeight,
                    ),
            ),
          ),
        ),
        if (onRemove != null)
          Positioned(
            top: 0,
            right: 0,
            child: Material(
              borderRadius: BorderRadius.circular(50.0),
              elevation: 1.0,
              shadowColor: Colors.grey.shade900,
              child: InkWell(
                borderRadius: BorderRadius.circular(50.0),
                onTap: onRemove,
                child: Icon(Ionicons.close_outline),
              ),
            ),
          ),
        if (file.type == MediaFileType.video)
          Positioned.fill(
              child: Align(
            alignment: Alignment.center,
            child: PlayButton(),
          ))
      ],
    );
  }
}
