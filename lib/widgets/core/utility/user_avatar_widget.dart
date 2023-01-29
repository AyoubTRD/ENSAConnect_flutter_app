import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({Key? key, this.avatarPath, this.radius = 32.0})
      : super(key: key);

  final String? avatarPath;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      foregroundImage: avatarPath != null ? NetworkImage(avatarPath!) : null,
      backgroundColor: Colors.grey.shade200,
      child: avatarPath == null
          ? Icon(
              Ionicons.person,
              color: Theme.of(context).primaryColor.withOpacity(0.8),
              size: radius - 4.0,
            )
          : null,
      radius: radius,
    );
  }
}
