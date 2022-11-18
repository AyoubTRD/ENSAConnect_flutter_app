import 'package:ensa/models/notification_model.dart';
import 'package:ensa/screens/paged_screen.dart';
import 'package:ensa/utils/constants.dart';
import 'package:ensa/widgets/core/app_bar_widget.dart';
import 'package:ensa/widgets/notification_widget.dart';
import 'package:flutter/material.dart';

final List<AppNotification> notifications = [
  AppNotification(
    id: '1',
    type: NotificationType.FRIEND_REQUEST,
    user: kUsers[0],
  ),
  AppNotification(id: '10', type: NotificationType.POST_LIKED, user: kUsers[0]),
  AppNotification(
      id: '9', type: NotificationType.COMMENT_REPLY, user: kUsers[0]),
  AppNotification(
      id: '11', type: NotificationType.COMMENT_LIKED, user: kUsers[0]),
  AppNotification(
      id: '12', type: NotificationType.NEW_COMMENT, user: kUsers[0]),
  AppNotification(id: '13', type: NotificationType.NEW_POST, user: kUsers[0]),
  AppNotification(
      id: '15',
      type: NotificationType.FRIEND_REQUEST_ACCEPTED,
      user: kUsers[0]),
  AppNotification(
    id: '2',
    type: NotificationType.FRIEND_REQUEST,
    user: kUsers[1],
  ),
  AppNotification(
    id: '3',
    type: NotificationType.FRIEND_REQUEST,
    user: kUsers[2],
  ),
];

class NotificationsScreen extends StatefulWidget {
  static const routeName = '/notifications';
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    List<AppNotification> friendRequestNotifications = notifications
        .where((element) => element.type == NotificationType.FRIEND_REQUEST)
        .toList();
    List<AppNotification> activityNotifications = notifications
        .where((element) => element.type != NotificationType.FRIEND_REQUEST)
        .toList();

    return PagedScreen(
      pageNames: ['Friend Requests', 'Activity'],
      pageCount: 2,
      appBar: MyAppBar(
        centerTitle: true,
        showBackButton: true,
        title: Text(
          'Notifications',
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding, vertical: 8.0),
              child: Text('${friendRequestNotifications.length} requests'),
            ),
            Expanded(
              child: ListView.separated(
                physics: BouncingScrollPhysics(),
                separatorBuilder: (_, i) => Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: Divider(),
                ),
                itemCount: friendRequestNotifications.length,
                itemBuilder: (_, i) => Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: NotificationWidget(
                    friendRequestNotifications[i],
                    key: Key(friendRequestNotifications[i].id),
                  ),
                ),
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding, vertical: 8.0),
              child: Text('${activityNotifications.length} notifications'),
            ),
            Expanded(
              child: ListView.separated(
                physics: BouncingScrollPhysics(),
                separatorBuilder: (_, i) => Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: Divider(),
                ),
                itemCount: activityNotifications.length,
                itemBuilder: (_, i) => Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: NotificationWidget(
                    activityNotifications[i],
                    key: Key(activityNotifications[i].id),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );

    // return Scaffold(
    //   appBar: MyAppBar(
    //     title: Text(
    //       'Notifications',
    //       style: Theme.of(context).textTheme.headline3,
    //     ),
    //     centerTitle: true,
    //     showBackButton: true,
    //   ),
    //   body: Center(
    //     child: Column(
    //       children: [
    //         Container(
    //           margin: const EdgeInsets.symmetric(vertical: kDefaultPadding),
    //           child: Container(
    //             decoration: BoxDecoration(
    //               color: Colors.grey[200],
    //               borderRadius: BorderRadius.circular(8.0),
    //             ),
    //             child: ToggleButtons(
    //               isSelected: isSelected,
    //               constraints: BoxConstraints(
    //                 minWidth:
    //                     (MediaQuery.of(context).size.width - kDefaultPadding) /
    //                         2,
    //                 minHeight: 43.0,
    //               ),
    //               selectedColor: Colors.white,
    //               color: Colors.grey[800],
    //               fillColor: Theme.of(context).primaryColor,
    //               borderWidth: 0.0,
    //               borderRadius: BorderRadius.circular(8.0),
    //               onPressed: (int index) {
    //                 setState(() {
    //                   _currentIndex = index;
    //                 });
    //                 _scrollToPage();
    //               },
    //               children: [
    //                 Text('Friend Requests'),
    //                 Text('Activity'),
    //               ],
    //             ),
    //           ),
    //         ),
    //         Expanded(
    //           child: PageView(
    //             controller: _controller,
    //             physics: BouncingScrollPhysics(),
    //             scrollDirection: Axis.horizontal,
    //             children: [
    //
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
