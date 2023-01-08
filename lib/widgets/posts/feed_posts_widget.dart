import 'package:ensa/blocs/posts_bloc.dart';
import 'package:ensa/graphql/graphql_api.dart';
import 'package:ensa/utils/constants.dart';
import 'package:ensa/widgets/posts/feed_post_widget.dart';
import 'package:flutter/material.dart';

class FeedPosts extends StatelessWidget {
  const FeedPosts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FeedPostMixin>>(
      future: postsBloc.getFeedPosts(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text('Loading...');
        }
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
