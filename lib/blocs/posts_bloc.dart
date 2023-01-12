import 'package:ensa/graphql/graphql_api.dart';
import 'package:ensa/utils/artemis_client.dart';
import 'package:rxdart/rxdart.dart';

class CreatePostError extends Error {}

class LoadFeedPostsError extends Error {}

class DeletePostError extends Error {}

class PostsBloc {
  BehaviorSubject<List<FeedPostMixin>> _feedPosts = BehaviorSubject.seeded([]);

  ValueStream<List<FeedPostMixin>> get feedPosts => _feedPosts.stream;

  Future<void> createPost({required String text, List<String>? files}) async {
    final variables = CreatePostArguments(
      post: CreatePostInput(
        text: text,
        files: files,
      ),
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

    _feedPosts.sink.add(response.data!.getPosts);

    return response.data!.getPosts;
  }

  Future<bool> deletePost(String postId) async {
    final mutation = DeletePostMutation(
      variables: DeletePostArguments(postId: postId),
    );
    final response = await apiClient.execute(mutation);

    if (response.hasErrors) {
      print(response.errors);
      throw DeletePostError();
    }

    final List<FeedPostMixin> newPosts = List.from(feedPosts.value);
    newPosts.removeWhere((element) => element.id == postId);

    _feedPosts.sink.add(newPosts);

    return response.data!.deletePost;
  }

  void dispose() {
    _feedPosts.close();
  }
}

final postsBloc = PostsBloc();
