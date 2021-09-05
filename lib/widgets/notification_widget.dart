import 'package:ensa/models/notification_model.dart';
import 'package:flutter/material.dart';

class MyNotification extends StatelessWidget {
  const MyNotification(this._notification, {Key? key}) : super(key: key);

  final AppNotification _notification;

  @override
  Widget build(BuildContext context) {
    Widget notificationWidget = Container();

    if (_notification.type == NotificationType.FRIEND_REQUEST) {
      notificationWidget = _buildFriendRequestNotification(context);
    } else
      notificationWidget = _buildActivityNotification(context);

    return Container(
      height: 70.0,
      child: notificationWidget,
    );
  }

  Widget _buildFriendRequestNotification(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: Theme.of(context).accentColor.withOpacity(0.1),
          backgroundImage: NetworkImage(_notification.user!.profilePicture),
          radius: 25.0,
        ),
        SizedBox(
          width: 9.0,
        ),
        Expanded(
          child: Text(
            _notification.user!.fullName,
            maxLines: 1,
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        RawMaterialButton(
          onPressed: () {},
          fillColor: Colors.red.withOpacity(0.1),
          elevation: 0.0,
          focusElevation: 0.0,
          constraints: BoxConstraints(minWidth: 70.0, minHeight: 30.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          child: Text(
            'Delete',
            style: TextStyle(color: Colors.red, fontSize: 16.0),
          ),
        ),
        SizedBox(
          width: 10.0,
        ),
        RawMaterialButton(
          onPressed: () {},
          fillColor: Theme.of(context).primaryColor,
          elevation: 0.0,
          focusElevation: 0.0,
          constraints: BoxConstraints(minWidth: 70.0, minHeight: 30.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          child: Text(
            'Confirm',
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
      ],
    );
  }

  Widget _buildActivityNotification(BuildContext context) {
    Map<NotificationType, String> text = {
      NotificationType.FRIEND_REQUEST_ACCEPTED: 'Accepted your friend request.',
      NotificationType.NEW_COMMENT: 'Commented on your post.',
      NotificationType.COMMENT_REPLY: 'Replied to your comment.',
      NotificationType.COMMENT_LIKED: 'Liked your comment.',
      NotificationType.POST_LIKED: 'Liked your post.',
      NotificationType.NEW_POST: 'Created a new post.',
    };

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 25.0,
          backgroundColor: Theme.of(context).accentColor.withOpacity(0.1),
          backgroundImage: NetworkImage(_notification.user!.profilePicture),
        ),
        SizedBox(
          width: 10.0,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _notification.user!.fullName,
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(text[_notification.type]!),
          ],
        ),
      ],
    );
  }
}
