import 'package:ensa/blocs/posts_bloc.dart';
import 'package:ensa/utils/constants.dart';
import 'package:ensa/widgets/posts/feed_posts_widget.dart';
import 'package:ensa/widgets/stories/stories_preview_widget.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen>
    with AutomaticKeepAliveClientMixin<FeedScreen> {
  @override
  bool get wantKeepAlive => true;

  final RefreshController refreshController = RefreshController(
    initialRefresh: false,
  );

  Future<void> onRefresh() async {
    await postsBloc.getFeedPosts();

    refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? Color(0xF0F1F7FF)
          : null,
      body: Column(
        children: [
          Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            padding: EdgeInsets.only(
              right: kDefaultPadding,
              left: kDefaultPadding,
              top: kDefaultPadding + MediaQuery.of(context).padding.top,
              bottom: 0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ENSA Connect',
                  style: Theme.of(context)
                      .textTheme
                      .headline2
                      ?.copyWith(fontSize: 35.0),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/notifications');
                  },
                  icon: Icon(Ionicons.notifications_outline),
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : kTextSecondary,
                )
              ],
            ),
          ),
          Expanded(
            child: SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              controller: refreshController,
              onRefresh: onRefresh,
              child: ListView(
                padding: const EdgeInsets.only(bottom: 32.0),
                physics: BouncingScrollPhysics(),
                children: [
                  Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.only(
                            left: kDefaultPadding,
                            top: kDefaultPadding,
                          ),
                          child: Text(
                            'Featured stories',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Container(
                          height: 110.0,
                          child: StoriesPreview(),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(kDefaultPadding),
                    child: FeedPosts(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
