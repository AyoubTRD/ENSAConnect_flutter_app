import 'package:ensa/widgets/posts/post_media_item_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

enum MediaType { IMAGE, VIDEO }

class UploadedMediaFile {
  MediaType type;
  String? path;
  bool isUploading;
  XFile? file;
  Uint8List? bytes;

  UploadedMediaFile({
    required this.type,
    required this.isUploading,
    this.path,
    this.file,
    this.bytes,
  });
}
