import 'dart:convert';
import 'dart:io';

import 'package:ensa/graphql/graphql_api.dart';
import 'package:ensa/utils/artemis_client.dart';
import 'package:ensa/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class UploadedFileResponse {
  final String filePath;
  final String id;

  const UploadedFileResponse({required this.filePath, required this.id});
}

class RestClientService {
  Future<UploadedFileResponse> uploadFile(
    XFile file, {
    MediaFileType type = MediaFileType.image,
  }) async {
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

    final request =
        http.MultipartRequest('POST', Uri.parse(kRestAPIUrl + slug));

    request.files.add(
      http.MultipartFile.fromBytes(
        'file',
        await File.fromUri(Uri.parse(file.path)).readAsBytes(),
        filename: file.name,
      ),
    );

    final response = await authClient.send(request);

    if (response.statusCode != 200) {
      throw Error();
    }
    final body = jsonDecode(await utf8.decodeStream(response.stream));

    return UploadedFileResponse(filePath: body['filePath'], id: body['_id']);
  }
}

final restClientService = RestClientService();
