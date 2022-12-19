import 'package:ensa/graphql/graphql_api.dart';
import 'package:ensa/utils/artemis_client.dart';
import 'package:rxdart/rxdart.dart';

class CreatePostError extends Error {}

class LoadFeedPostsError extends Error {}

class PostsBloc {
  BehaviorSubject<List<FeedPostMixin>> _feedPosts = BehaviorSubject.seeded([]);

  ValueStream<List<FeedPostMixin>> get feedPosts => _feedPosts.stream;

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

  Future<List<FeedPostMixin>> getFeedPosts() async {
    final query = GetFeedPostsQuery();
    final response = await apiClient.execute(query);

    if (response.hasErrors) {
      print(response.errors);
      throw LoadFeedPostsError();
    }

    return response.data!.getPosts;
  }

  void dispose() {
    _feedPosts.close();
  }
}

final postsBloc = PostsBloc();
