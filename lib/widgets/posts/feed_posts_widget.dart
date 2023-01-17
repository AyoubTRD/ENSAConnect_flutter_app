import 'package:ensa/blocs/posts_bloc.dart';
import 'package:ensa/graphql/graphql_api.dart';
import 'package:ensa/utils/constants.dart';
import 'package:ensa/widgets/core/empty_state_widget.dart';
import 'package:ensa/widgets/posts/feed_post_widget.dart';
import 'package:flutter/material.dart';

class FeedPosts extends StatefulWidget {
  const FeedPosts({Key? key}) : super(key: key);

  @override
  State<FeedPosts> createState() => _FeedPostsState();
}

class _FeedPostsState extends State<FeedPosts> {
  @override
  void initState() {
    super.initState();

    postsBloc.getFeedPosts();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<FeedPostMixin>>(
      stream: postsBloc.feedPosts,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text('Loading...');
        }
        if (snapshot.data!.isEmpty)
          return EmptyState(
            text: 'No posts available today',
          );
        return Column(
          children: snapshot.data!
              .map(
                (e) => Container(
                  margin: const EdgeInsets.only(bottom: kDefaultPadding),
                  child: FeedPost(
                    e,
                    key: Key(e.id),
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}
