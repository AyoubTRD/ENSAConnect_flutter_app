import 'package:artemis/artemis.dart';
import 'package:ensa/graphql/graphql_api.dart';
import 'package:ensa/utils/artemis_client.dart';
import 'package:ensa/utils/constants.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmailTakenError extends Error {}

class AuthRequestError extends Error {}

class InvalidCredentialsError extends Error {}

class InvalidEmailError extends InvalidCredentialsError {}

class InvalidPasswordError extends InvalidCredentialsError {}

class AuthBloc {
  BehaviorSubject<bool> _isReady = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> _isAuthenticated = BehaviorSubject.seeded(false);
  BehaviorSubject<UserMixin> _currentUser = BehaviorSubject<UserMixin>();

  ValueStream<bool> get isReady => _isReady.stream;
  ValueStream<bool> get isAuthenticated => _isAuthenticated.stream;
  ValueStream<UserMixin> get currentUser => _currentUser.stream;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null && token != '') {
      updateToAuthenticatedClient(token);
      final query = GetMeQuery();
      final response = await client.execute(query);
      if (response.hasErrors) {
        print(response.errors);
        await prefs.remove('token');
      } else {
        _isAuthenticated.sink.add(true);
        _currentUser.sink.add(response.data!.getMe);
      }
    }
    _isReady.sink.add(true);
  }

  void updateToAuthenticatedClient(String token) {
    client =
        ArtemisClient(kApiUrl, httpClient: AuthenticatedClient(token: token));
  }

  void updateToRegularClient() {
    client = ArtemisClient(kApiUrl);
  }

  void handleAuthSuccess(
      {required String token, required UserMixin user}) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
    _currentUser.sink.add(user);
    _isAuthenticated.sink.add(true);
    client =
        ArtemisClient(kApiUrl, httpClient: AuthenticatedClient(token: token));
  }

  Future<void> signUp(UserInput user) async {
    final variables = CreateUserArguments(user: user);
    final response =
        await client.execute(CreateUserMutation(variables: variables));
    if (response.hasErrors) {
      if (response.errors![0].message == 'email_taken') throw EmailTakenError();
      print(response.errors);
      throw AuthRequestError();
    }
    handleAuthSuccess(
        token: response.data!.createUser.token,
        user: response.data!.createUser.user);
  }

  Future<void> signIn(Credentials credentials) async {
    final variables = GetTokenArguments(credentials: credentials);
    final query = GetTokenQuery(variables: variables);
    final response = await client.execute(query);
    if (response.hasErrors) {
      if (response.errors![0].message == 'wrong_email')
        throw InvalidEmailError();
      if (response.errors![0].message == 'wrong_password')
        throw InvalidPasswordError();
      print(response.errors);
      throw AuthRequestError();
    }
    handleAuthSuccess(
        token: response.data!.getToken.token,
        user: response.data!.getToken.user);
  }

  void dispose() {
    _isReady.close();
    _isAuthenticated.close();
    _currentUser.close();
  }
}

final authBloc = AuthBloc();
