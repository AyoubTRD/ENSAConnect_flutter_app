import 'package:ensa/models/notification_model.dart';
import 'package:flutter/material.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget(this._notification, {Key? key}) : super(key: key);

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
    return ListTile(
      onTap: () {},
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).accentColor.withOpacity(0.1),
        backgroundImage: NetworkImage(_notification.user!.profilePicture),
        radius: 32.5,
      ),
      title: Text(
        _notification.user!.fullName,
        maxLines: 1,
        style: Theme.of(context).textTheme.headline4,
      ),
      subtitle: Text(
        'Sent you a friend request',
        style: TextStyle(fontSize: 16.0),
      ),
      contentPadding: EdgeInsets.zero,
      dense: true,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(50.0),
            ),
            child: IconButton(
              onPressed: () {},
              highlightColor: Colors.transparent,
              icon: Icon(
                Icons.delete_outline,
                color: Colors.red,
              ),
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(50.0),
            ),
            child: IconButton(
              onPressed: () {},
              highlightColor: Colors.transparent,
              icon: Icon(
                Icons.check,
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),
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

    return ListTile(
      onTap: () {},
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).accentColor.withOpacity(0.1),
        backgroundImage: NetworkImage(_notification.user!.profilePicture),
        radius: 32.5,
      ),
      title: Text(
        _notification.user!.fullName,
        maxLines: 1,
        style: Theme.of(context).textTheme.headline4,
      ),
      subtitle: Text(text[_notification.type]!),
    );
  }
}
