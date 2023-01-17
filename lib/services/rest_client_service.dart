import 'dart:convert';
import 'dart:io';

import 'package:ensa/graphql/graphql_api.dart';
import 'package:ensa/utils/artemis_client.dart';
import 'package:ensa/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class UploadedFileResponse {
  final String filePath;
  final String id;

  const UploadedFileResponse({required this.filePath, required this.id});
}

class RestClientService {
  Uri _getUploadURI(MediaFileType type) {
    late String slug;
    if (type == MediaFileType.image) {
      slug = '/upload-image';
    } else if (type == MediaFileType.video) {
      slug = '/upload-video';
    } else if (type == MediaFileType.document) {
      slug = '/upload-document';
    } else if (type == MediaFileType.other) {
      slug = '/upload-other';
    } else {
      throw Error();
    }

    return Uri.parse(kRestAPIUrl + slug);
  }

  Future<UploadedFileResponse> _executeUploadRequest(
      http.MultipartRequest request) async {
    final response = await authClient.send(request);

    if (response.statusCode != 200) {
      throw Error();
    }
    final body = jsonDecode(await utf8.decodeStream(response.stream));

    return UploadedFileResponse(filePath: body['filePath'], id: body['_id']);
  }

  Future<UploadedFileResponse> uploadXFile(
    XFile file, {
    MediaFileType type = MediaFileType.image,
  }) async {
    final request = http.MultipartRequest(
      'POST',
      _getUploadURI(type),
    );

    request.files.add(
      http.MultipartFile.fromBytes(
        'file',
        await file.readAsBytes(),
        filename: file.name,
      ),
    );

    return _executeUploadRequest(request);
  }

  Future<UploadedFileResponse> uploadAssetEntity(
    AssetEntity entity, {
    MediaFileType type = MediaFileType.image,
  }) async {
    final request = http.MultipartRequest(
      'POST',
      _getUploadURI(type),
    );

    final file = await entity.file;
    if (file == null) throw Error();

    request.files.add(
      http.MultipartFile.fromBytes(
        'file',
        await file.readAsBytes(),
        filename: await entity.titleAsync,
      ),
    );

    return _executeUploadRequest(request);
  }
}

final restClientService = RestClientService();
