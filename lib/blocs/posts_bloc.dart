import 'package:ensa/graphql/graphql_api.dart';
import 'package:ensa/utils/artemis_client.dart';
import 'package:rxdart/rxdart.dart';

class CreatePostError extends Error {}

class UpdatePostError extends Error {}

class LoadFeedPostsError extends Error {}

class DeletePostError extends Error {}

class PostsBloc {
  late BehaviorSubject<List<FeedPostMixin>> _feedPosts = BehaviorSubject();

  ValueStream<List<FeedPostMixin>> get feedPosts => _feedPosts.stream;

  Future<void> createPost({required String text, List<String>? fileIds}) async {
    final variables = CreatePostArguments(
      post: CreatePostInput(
        text: text,
        fileIds: fileIds,
      ),
    );

    final mutation = CreatePostMutation(variables: variables);
    final response = await apiClient.execute(mutation);

    if (response.hasErrors) {
      print(response.errors);
      throw CreatePostError();
    }

    if (feedPosts.hasValue) {
      final posts = feedPosts.value;
      posts.add(response.data!.createPost as FeedPostMixin);

      _feedPosts.sink.add(posts);
    }
  }

  Future<void> updatePost({
    required String postId,
    required String text,
    List<String>? fileIds,
  }) async {
    final variables = UpdatePostArguments(
      postId: postId,
      input: UpdatePostInput(
        text: text,
        fileIds: fileIds,
      ),
    );

    final mutation = UpdatePostMutation(variables: variables);
    final response = await apiClient.execute(mutation);

    if (response.hasErrors) {
      print(response.errors);
      throw UpdatePostError();
    }

    final FeedPostMixin updatedPost = response.data!.updatePost;

    if (feedPosts.hasValue) {
      _feedPosts.sink.add(
        feedPosts.value
            .map((e) => e.id == updatedPost.id ? updatedPost : e)
            .toList(),
      );
    }
  }

  Future<List<FeedPostMixin>> getFeedPosts() async {
    final query = GetFeedPostsQuery();
    final response = await apiClient.execute(query);

    if (response.hasErrors) {
      print(response.errors);
      throw LoadFeedPostsError();
    }

    final List<FeedPostMixin> posts = response.data!.getPosts;

    _feedPosts.sink.add(posts);

    return posts;
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
