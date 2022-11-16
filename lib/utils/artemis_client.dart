import 'package:artemis/artemis.dart';
import 'package:ensa/utils/constants.dart';
import 'package:http/http.dart' as http;

class AuthenticatedClient extends http.BaseClient {
  String? token;
  AuthenticatedClient();

  final http.Client _inner = http.Client();

  Future<http.StreamedResponse> send(http.BaseRequest request) {
    if (token != null) {
      request.headers['authorization'] = token!;
    }
    return _inner.send(request);
  }

  void setToken(String newToken) {
    this.token = newToken;
  }

  void removeToken() {
    this.token = null;
  }
}

final authClient = AuthenticatedClient();
final apiClient = ArtemisClient(kApiUrl, httpClient: authClient);
