import 'package:artemis/artemis.dart';
import 'package:ensa/utils/constants.dart';
import 'package:http/http.dart' as http;

class AuthenticatedClient extends http.BaseClient {
  final String token;
  AuthenticatedClient({required this.token});

  final http.Client _inner = http.Client();

  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers['authorization'] = token;
    return _inner.send(request);
  }
}

ArtemisClient client = ArtemisClient(kApiUrl);
