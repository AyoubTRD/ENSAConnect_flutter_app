import 'package:ensa/utils/constants.dart';
import 'package:ensa/widgets/posts/feed_posts_widget.dart';
import 'package:ensa/widgets/stories/stories_preview_widget.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
            right: kDefaultPadding,
            left: kDefaultPadding,
            top: kDefaultPadding + MediaQuery.of(context).padding.top,
            bottom: 0,
          ),
          color: Colors.transparent,
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
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Padding(
                padding: const EdgeInsets.only(left: kDefaultPadding),
                child: Text(
                  'Featured stories',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              SizedBox(
                height: 100.0,
                child: StoriesPreview(),
              ),
              Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: FeedPosts(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
