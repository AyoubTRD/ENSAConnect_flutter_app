import 'package:artemis/artemis.dart';
import 'package:ensa/graphql/graphql_api.dart';
import 'package:ensa/utils/artemis_client.dart';
import 'package:ensa/utils/constants.dart';
import 'package:rxdart/rxdart.dart';

class EmailTakenError extends Error {}

class AuthRequestError extends Error {}

class AuthBloc {
  BehaviorSubject<bool> _isAuthenticated = BehaviorSubject.seeded(false);
  BehaviorSubject<UserMixin> _currentUser = BehaviorSubject<UserMixin>();

  ValueStream<bool> get isAuthenticated => _isAuthenticated.stream;
  ValueStream<UserMixin> get currentUser => _currentUser.stream;

  Future<void> signUp(UserInput user) async {
    final variables = CreateUserArguments(user: user);
    final response =
        await client.execute(CreateUserMutation(variables: variables));
    if (response.hasErrors) {
      if (response.errors![0].message == 'email_taken') throw EmailTakenError();
      throw AuthRequestError();
    }
    _currentUser.sink.add(response.data!.createUser.user);
    _isAuthenticated.sink.add(true);
    client = ArtemisClient(kApiUrl,
        httpClient:
            AuthenticatedClient(token: response.data!.createUser.token));
  }

  Future<void> signIn(Credentials credentials) async {
    final variables = GetTokenArguments(credentials: credentials);
    final query = GetTokenQuery(variables: variables);
    final response = await client.execute(query);
  }

  void dispose() {
    _isAuthenticated.close();
    _currentUser.close();
  }
}

final authBloc = AuthBloc();
