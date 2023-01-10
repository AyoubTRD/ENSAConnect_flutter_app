import 'dart:io';

import 'package:ensa/blocs/user_bloc.dart';
import 'package:ensa/graphql/graphql_api.dart';
import 'package:ensa/utils/constants.dart';
import 'package:ensa/widgets/posts/feed_post_options_sheet_widget.dart';
import 'package:ensa/widgets/posts/post_media_widget.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:readmore/readmore.dart';
import 'package:timeago/timeago.dart' as timeago;

class FeedPost extends StatelessWidget {
  FeedPost(this.post, {Key? key}) : super(key: key);

  final FeedPostMixin post;

  bool get _hasContent => post.text.isNotEmpty;
  bool get _hasMedia => post.files.isNotEmpty;

  bool get isOwnPost => userBloc.currentUser.value?.id == post.author.id;

  void handleOpenPostSettings(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => PostOptionsSheet(post: post),
    );
  }

  BoxShadow getShadow(BuildContext context) => BoxShadow(
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white.withOpacity(0.05)
            : Colors.black.withOpacity(0.05),
        blurRadius: 10.0,
        offset: const Offset(0, 10.0),
        spreadRadius: 2.0,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.0),
        gradient: Theme.of(context).brightness == Brightness.dark
            ? LinearGradient(
                tileMode: TileMode.clamp,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.grey.shade800.withOpacity(0.75),
                  Colors.grey.shade800.withOpacity(0.5),
                ],
              )
            : null,
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey.shade900.withOpacity(0.5)
            : Colors.white,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor:
                          Theme.of(context).accentColor.withOpacity(0.1),
                      backgroundImage: NetworkImage(
                        (post.author.avatar == null || post.author.avatar == '')
                            ? kDefaultProfilePic
                            : post.author.avatar!,
                      ),
                      radius: 26.0,
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    SizedBox(
                      height: 46.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            post.author.fullName,
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          Text(
                            timeago.format(post.createdAt),
                            style:
                                Theme.of(context).textTheme.bodyText1?.copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          ?.color
                                          ?.withOpacity(0.6),
                                    ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    InkWell(
                      onTap: () => handleOpenPostSettings(context),
                      child: Icon(
                        Ionicons.ellipsis_horizontal_outline,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: kDefaultPadding,
                ),
                if (_hasContent)
                  SizedBox(
                    width: double.infinity,
                    child: ReadMoreText(
                      post.text,
                      trimLines: 5,
                      trimCollapsedText: 'Show more',
                      trimExpandedText: ' Show less',
                      trimMode: TrimMode.Line,
                      textAlign: TextAlign.left,
                      moreStyle: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                      lessStyle: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          if (_hasMedia) PostMedia(post),
          _buildBar(context),
        ],
      ),
    );
  }

  Widget _buildBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: kDefaultPadding,
        left: 16.0,
        right: 16.0,
      ),
      child: _buildBarBody(context),
    );
  }

  Widget _buildBarBody(BuildContext context) {
    double iconSize = 24.0;
    double textSize = 16.0;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Icon(
          Ionicons.heart_outline,
          color: kTextSecondary,
          size: iconSize,
        ),
        SizedBox(width: 3.0),
        Text(
          '0',
          style: TextStyle(fontSize: textSize),
        ),
        SizedBox(
          width: 15.0,
        ),
        Icon(
          Ionicons.chatbubble_ellipses_outline,
          color: kTextSecondary,
          size: iconSize,
        ),
        SizedBox(width: 3.0),
        Text(
          '0',
          style: TextStyle(fontSize: textSize),
        ),
        Expanded(child: Container()),
        Icon(
          Ionicons.bookmark_outline,
          color: kTextSecondary,
          size: iconSize,
        ),
      ],
    );
  }
}
