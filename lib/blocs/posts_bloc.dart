import 'package:ensa/graphql/graphql_api.dart';
import 'package:ensa/utils/artemis_client.dart';

class CreatePostError extends Error {}

class PostsBloc {
  Future<void> createPost({required String text}) async {
    final variables = CreatePostArguments(
      post: PostInput(text: text),
    );

    final mutation = CreatePostMutation(variables: variables);
    final response = await apiClient.execute(mutation);

    if (response.hasErrors) {
      print(response.errors);
      throw CreatePostError();
    }
  }
}

final postsBloc = PostsBloc();
