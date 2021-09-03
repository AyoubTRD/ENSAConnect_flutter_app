import 'package:ensa/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    Key? key,
    this.preferredSize = const Size.fromHeight(kToolbarHeight + 20.0),
    this.backgroundColor,
    this.showBackButton = true,
    this.title,
    this.centerTitle,
  }) : super(key: key);

  final Size preferredSize;
  final Color? backgroundColor;
  final bool showBackButton;
  final Widget? title;
  final bool? centerTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        leading: showBackButton
            ? IconButton(
                highlightColor: Colors.transparent,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Ionicons.chevron_back,
                  color: kTitleText,
                ),
                iconSize: 26.0,
              )
            : null,
        title: title,
        centerTitle: centerTitle,
      ),
    );
  }
}
