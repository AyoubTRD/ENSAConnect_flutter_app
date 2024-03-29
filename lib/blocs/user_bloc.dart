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

class UpdatePhoneNumberError extends Error {}

class GetUsersError extends Error {}

class UserBloc {
  late BehaviorSubject<bool> _isReady = BehaviorSubject.seeded(false);
  late BehaviorSubject<bool> _isAuthenticated = BehaviorSubject.seeded(false);
  late BehaviorSubject<UserMixin?> _currentUser = BehaviorSubject<UserMixin?>();
  late BehaviorSubject<List<PublicUserMixin>> _publicUsers = BehaviorSubject();

  ValueStream<bool> get isReady => _isReady.stream;
  ValueStream<bool> get isAuthenticated => _isAuthenticated.stream;
  ValueStream<UserMixin?> get currentUser => _currentUser.stream;
  ValueStream<List<PublicUserMixin>> get publicUsers => _publicUsers.stream;

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

  Future<List<PublicUserMixin>> getAllUsers() async {
    final query = GetUsersQuery();

    final response = await apiClient.execute(query);

    if (response.hasErrors) {
      print(response.errors);
      throw GetUsersError();
    }

    final List<PublicUserMixin> publicUsers = response.data!.getAllUsers;
    print(publicUsers);
    this._publicUsers.sink.add(publicUsers);

    return publicUsers;
  }

  void handleAuthSuccess(
      {required String token, required UserMixin user}) async {
    final prefsInstance = await SharedPreferences.getInstance();
    await prefsInstance.setString('token', token);

    _currentUser.sink.add(user);
    _isAuthenticated.sink.add(true);

    authClient.setToken(token);
  }

  Future<void> signUp(CreateUserInput user) async {
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

  Future<void> signIn(CredentialsInput credentials) async {
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

  Future<void> _updateUser({
    required UpdateUserArguments variables,
    required UpdateUserMutation mutation,
  }) async {
    final response = await apiClient.execute(mutation);

    if (response.hasErrors && response.errors != null) {
      print(response.errors);
      throw response.errors![0];
    }

    _currentUser.sink.add(response.data!.updateUser);
  }

  Future<void> updateProfilePicture(String profilePictureFileId) async {
    final variables = UpdateUserArguments(
      user: UpdateUserInput(avatarFileId: profilePictureFileId),
    );
    final mutation = UpdateUserMutation(variables: variables);

    await _updateUser(variables: variables, mutation: mutation);
  }

  Future<void> updateName(String firstName, String lastName) async {
    final variables = UpdateUserArguments(
      user: UpdateUserInput(firstName: firstName, lastName: lastName),
    );
    final mutation = UpdateUserMutation(variables: variables);

    await _updateUser(variables: variables, mutation: mutation);
  }

  Future<void> updatePassword(String oldPassword, String newPassword) async {
    final variables = UpdateUserArguments(
      user: UpdateUserInput(oldPassword: oldPassword, password: newPassword),
    );
    final mutation = UpdateUserMutation(variables: variables);

    await _updateUser(variables: variables, mutation: mutation);
  }

  Future<void> updatePhoneNumber(String phoneNumber) async {
    final variables = UpdateUserArguments(
      user: UpdateUserInput(phoneNumber: phoneNumber),
    );
    final mutation = UpdateUserMutation(variables: variables);

    await _updateUser(variables: variables, mutation: mutation);
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
    _publicUsers.close();
  }
}

final userBloc = UserBloc();
