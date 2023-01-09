import 'dart:convert';
import 'dart:io';

import 'package:ensa/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class RestClientService {
  Future<String> uploadFile(XFile file) async {
    final request =
        http.MultipartRequest('POST', Uri.parse(kRestAPIUrl + '/upload'));

    request.files.add(
      http.MultipartFile.fromBytes(
        'file',
        await File.fromUri(Uri.parse(file.path)).readAsBytes(),
        filename: file.name,
      ),
    );

    final response = await request.send();

    if (response.statusCode != 200) {
      throw Error();
    }
    final body = jsonDecode(await utf8.decodeStream(response.stream));

    return body['filePath'];
  }
}

final restClientService = RestClientService();
