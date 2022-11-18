import 'package:ensa/models/post_model.dart';
import 'package:ensa/utils/constants.dart';
import 'package:ensa/widgets/posts/post_media_widget.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:timeago/timeago.dart' as timeago;

class FeedPost extends StatelessWidget {
  FeedPost(this.post, {Key? key}) : super(key: key);

  final Post post;

  bool get _hasContent => post.content != null && post.content != '';
  bool get _hasMedia => post.images.isNotEmpty || post.videos.isNotEmpty;

  final _shadow = BoxShadow(
    color: Colors.black.withOpacity(0.05),
    blurRadius: 10.0,
    offset: const Offset(0, 10.0),
    spreadRadius: 2.0,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 38.0),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Theme.of(context).accentColor.withOpacity(0.1),
                backgroundImage: NetworkImage(post.user.profilePicture),
                radius: 30.0,
              ),
              SizedBox(
                width: 15.0,
              ),
              SizedBox(
                height: 50.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.user.fullName,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    Text(
                      timeago.format(DateTime.parse(post.createdAt)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: kDefaultPadding,
          ),
          if (_hasContent)
            Text(
              post.content!,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
          _buildBar(context),
        ],
      ),
    );
  }

  Widget _buildBar(BuildContext context) {
    if (_hasMedia) {
      return Container(
        decoration: BoxDecoration(
          boxShadow: [_shadow],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              PostMedia(post),
              ClipPath(
                clipper: MyClipper(),
                child: Container(
                  height: 80.0,
                  padding: const EdgeInsets.only(
                      bottom: 8.0, top: 38.0, left: 30.0, right: 30.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: _buildBarBody(context),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Container(
      height: 50.0,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
        boxShadow: [_shadow],
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: _buildBarBody(context),
    );
  }

  Widget _buildBarBody(BuildContext context) {
    double iconSize = 24.0;
    double textSize = 16.0;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Ionicons.heart_outline,
          color: kTextSecondary,
          size: iconSize,
        ),
        SizedBox(width: 3.0),
        Text(
          '${post.reactionsCount}',
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
          '${post.commentsCount}',
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

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
      3.0,
      25.0,
      50.0,
      25.0,
    );
    path.lineTo(size.width - 15.0, 25.0);
    path.quadraticBezierTo(
      size.width - 2.0,
      25.0,
      size.width,
      0,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> old) => true;
}
