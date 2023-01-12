import 'dart:io';

import 'package:ensa/blocs/posts_bloc.dart';
import 'package:ensa/blocs/user_bloc.dart';
import 'package:ensa/graphql/graphql_api.dart';
import 'package:ensa/widgets/settings/options_sheet_widget.dart';
import 'package:ensa/widgets/settings/settings_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ionicons/ionicons.dart';

class PostOptionsSheet extends StatelessWidget {
  const PostOptionsSheet({
    Key? key,
    required this.post,
  }) : super(key: key);

  final FeedPostMixin post;

  bool get isOwnPost => userBloc.currentUser.value?.id == post.author.id;

  Future<void> confirmDeletePost(BuildContext context) async {
    if (Platform.isAndroid) {
      showDialog(
        context: context,
        builder: (context) => MaterialDeletePostDialog(
          postId: post.id,
        ),
      );
    } else {
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoDeletePostDialog(
          postId: post.id,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return OptionsSheet(
      children: [
        SettingsItem(
          forceDarkText: true,
          title: const Text('Save'),
          icon: Ionicons.bookmark_outline,
          hideChevron: true,
        ),
        if (isOwnPost)
          SettingsItem(
            forceDarkText: true,
            title: const Text('Edit Post'),
            icon: Icons.edit_outlined,
          ),
        if (isOwnPost)
          SettingsItem(
            forceDarkText: true,
            onTap: () => confirmDeletePost(context),
            title: const Text('Delete Post'),
            icon: Ionicons.trash_outline,
            hideChevron: true,
            danger: true,
          ),
      ],
    );
  }
}

class MaterialDeletePostDialog extends StatefulWidget {
  const MaterialDeletePostDialog({Key? key, required this.postId})
      : super(key: key);

  final String postId;

  @override
  State<MaterialDeletePostDialog> createState() =>
      _MaterialDeletePostDialogState();
}

class _MaterialDeletePostDialogState extends State<MaterialDeletePostDialog> {
  bool isDeleting = false;

  Future<void> handleDeletePost(BuildContext context) async {
    setState(() {
      isDeleting = true;
    });

    try {
      await postsBloc.deletePost(widget.postId);
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    } catch (e) {
      print(e);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Something went wrong!',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
    setState(() {
      isDeleting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AlertDialog(
        title: Text('Are you sure you want to delete this post?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              handleDeletePost(context);
            },
            child: isDeleting
                ? SizedBox(
                    height: 16.0,
                    width: 16.0,
                    child: CircularProgressIndicator(
                      color: Colors.red,
                    ),
                  )
                : Text(
                    'Confirm',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
          )
        ],
      ),
    );
  }
}

class CupertinoDeletePostDialog extends StatefulWidget {
  const CupertinoDeletePostDialog({Key? key, required this.postId})
      : super(key: key);

  final String postId;

  @override
  State<CupertinoDeletePostDialog> createState() =>
      _CupertinoDeletePostDialogState();
}

class _CupertinoDeletePostDialogState extends State<CupertinoDeletePostDialog> {
  bool isDeleting = false;

  Future<void> handleDeletePost(BuildContext context) async {
    setState(() {
      isDeleting = true;
    });

    try {
      await postsBloc.deletePost(widget.postId);
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    } catch (e) {
      print(e);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Something went wrong!',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
    setState(() {
      isDeleting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CupertinoAlertDialog(
        title: Text('Are you sure you want to delete this post?'),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          CupertinoDialogAction(
            onPressed: () => handleDeletePost(context),
            child: isDeleting
                ? SizedBox(
                    width: 16.0,
                    height: 16.0,
                    child: CircularProgressIndicator(
                      color: Colors.red,
                    ),
                  )
                : Text(
                    'Confirm',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
