import 'package:ensa/graphql/graphql_api.dart';
import 'package:ensa/widgets/posts/post_media_item_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class UploadedMediaFile {
  MediaFileType type;
  String? path;
  bool isUploading;
  AssetEntity? entity;
  Uint8List? bytes;
  String? fileId;
  MediaFileMixin? mediaFile;

  UploadedMediaFile({
    required this.type,
    required this.isUploading,
    this.fileId,
    this.path,
    this.entity,
    this.bytes,
  });
}
