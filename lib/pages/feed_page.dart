import 'package:ensa/utils/constants.dart';
import 'package:ensa/widgets/posts_widget.dart';
import 'package:ensa/widgets/stories_preview_widget.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Ensocial',
                  style: Theme.of(context).textTheme.headline2,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Ionicons.notifications_outline),
                  color: kTextSecondary,
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
                  child: Posts(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
