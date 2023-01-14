import 'package:ensa/graphql/graphql_api.dart';
import 'package:ensa/widgets/posts/post_media_item_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class UploadedMediaFile {
  MediaFileType type;
  String? path;
  bool isUploading;
  XFile? file;
  Uint8List? bytes;
  String? fileId;

  UploadedMediaFile({
    required this.type,
    required this.isUploading,
    this.fileId,
    this.path,
    this.file,
    this.bytes,
  });
}
