import 'package:ensa/graphql/graphql_api.dart';
import 'package:ensa/utils/artemis_client.dart';
import 'package:ensa/utils/preferences_instant.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmailTakenError extends Error {}

class AuthRequestError extends Error {}

class InvalidCredentialsError extends Error {}

class InvalidEmailError extends InvalidCredentialsError {}

class InvalidPasswordError extends InvalidCredentialsError {}

class InvalidOldPasswordError extends Error {}

class DeleteSelfError extends Error {}

class UserBloc {
  BehaviorSubject<bool> _isReady = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> _isAuthenticated = BehaviorSubject.seeded(false);
  BehaviorSubject<UserMixin?> _currentUser = BehaviorSubject<UserMixin?>();

  ValueStream<bool> get isReady => _isReady.stream;
  ValueStream<bool> get isAuthenticated => _isAuthenticated.stream;
  ValueStream<UserMixin?> get currentUser => _currentUser.stream;

  Future<void> init() async {
    final token = prefsInstance.getString('token');

    if (token != null && token != '') {
      updateToAuthenticatedClient(token);

      final query = GetMeQuery();
      final response = await apiClient.execute(query);

      if (response.hasErrors) {
        print(response.errors);
        await prefsInstance.remove('token');
      } else {
        _isAuthenticated.sink.add(true);
        _currentUser.sink.add(response.data!.getMe);
      }
    }
    _isReady.sink.add(true);
  }

  void updateToAuthenticatedClient(String token) {
    authClient.setToken(token);
  }

  void updateToRegularClient() {
    authClient.removeToken();
  }

  void handleAuthSuccess(
      {required String token, required UserMixin user}) async {
    final prefsInstance = await SharedPreferences.getInstance();
    await prefsInstance.setString('token', token);

    // Restart.restartApp();

    _currentUser.sink.add(user);
    _isAuthenticated.sink.add(true);

    authClient.setToken(token);
  }

  Future<void> signUp(UserInput user) async {
    final variables = CreateUserArguments(user: user);
    final response =
        await apiClient.execute(CreateUserMutation(variables: variables));

    if (response.hasErrors) {
      if (response.errors![0].message == 'email_taken') throw EmailTakenError();
      print(response.errors);
      throw AuthRequestError();
    }

    handleAuthSuccess(
      token: response.data!.createUser.token,
      user: response.data!.createUser.user,
    );
  }

  Future<void> signIn(Credentials credentials) async {
    final variables = GetTokenArguments(credentials: credentials);
    final query = GetTokenQuery(variables: variables);
    final response = await apiClient.execute(query);

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
      user: response.data!.getToken.user,
    );
  }

  Future<void> logout() async {
    _isAuthenticated.sink.add(false);
    _currentUser.sink.add(null);

    authClient.removeToken();

    final prefsInstance = await SharedPreferences.getInstance();
    await prefsInstance.remove('token');
  }

  Future<void> updateProfilePicture(String profilePicture) async {
    final variables = UpdateUserArguments(
      user: UpdateUserInput(avatar: profilePicture),
    );
    final mutation = UpdateUserMutation(variables: variables);
    final response = await apiClient.execute(mutation);

    if (response.hasErrors && response.errors != null) {
      print(response.errors);
      throw response.errors![0];
    }

    _currentUser.sink.add(response.data!.updateUser);
  }

  Future<void> updateName(String firstName, String lastName) async {
    final variables = UpdateUserArguments(
      user: UpdateUserInput(firstName: firstName, lastName: lastName),
    );
    final mutation = UpdateUserMutation(variables: variables);
    final response = await apiClient.execute(mutation);

    if (response.hasErrors && response.errors != null) {
      print(response.errors);
      throw response.errors![0];
    }

    _currentUser.sink.add(response.data!.updateUser);
  }

  Future<void> updatePassword(String oldPassword, String newPassword) async {
    final variables = UpdateUserArguments(
      user: UpdateUserInput(oldPassword: oldPassword, password: newPassword),
    );
    final mutation = UpdateUserMutation(variables: variables);
    final response = await apiClient.execute(mutation);

    if (response.hasErrors && response.errors != null) {
      print(response.errors);
      throw InvalidOldPasswordError();
    }

    _currentUser.sink.add(response.data!.updateUser);
  }

  Future<void> deleteSelf() async {
    final response = await apiClient.execute(DeleteMeMutation());

    if (response.hasErrors && response.errors != null) {
      print(response.errors);
      throw DeleteSelfError();
    }

    await logout();
  }

  void dispose() {
    _isReady.close();
    _isAuthenticated.close();
    _currentUser.close();
  }
}

final userBloc = UserBloc();
