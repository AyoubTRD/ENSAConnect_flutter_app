import 'package:ensa/models/notification_model.dart';
import 'package:ensa/utils/constants.dart';
import 'package:ensa/widgets/app_bar_widget.dart';
import 'package:ensa/widgets/notification_widget.dart';
import 'package:flutter/material.dart';

final List<AppNotification> notifications = [
  AppNotification(
    id: '1',
    type: NotificationType.FRIEND_REQUEST,
    user: users[0],
  ),
  AppNotification(
    id: '2',
    type: NotificationType.FRIEND_REQUEST,
    user: users[1],
  ),
  AppNotification(
    id: '3',
    type: NotificationType.FRIEND_REQUEST,
    user: users[2],
  ),
];

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<bool> _selectedTabs = [true, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: Text(
          'Notifications',
          style: Theme.of(context).textTheme.headline3,
        ),
        centerTitle: true,
        showBackButton: true,
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: kDefaultPadding),
              child: ToggleButtons(
                isSelected: _selectedTabs,
                constraints: BoxConstraints(
                  minWidth:
                      (MediaQuery.of(context).size.width - kDefaultPadding) / 2,
                  minHeight: 45.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
                selectedColor: Colors.white,
                color: kTextSecondary,
                fillColor: Theme.of(context).primaryColor,
                onPressed: (int index) {
                  List<bool> selected = [false, false];
                  selected[index] = true;
                  setState(() {
                    _selectedTabs = selected;
                  });
                },
                children: [
                  Text('Friend Requests'),
                  Text('Activity'),
                ],
              ),
            ),
            Expanded(
              child: PageView(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${notifications.length} requests'),
                        Expanded(
                          child: ListView.separated(
                            itemCount: notifications.length,
                            itemBuilder: (_, i) => MyNotification(
                              notifications[i],
                              key: Key(notifications[i].id),
                            ),
                            separatorBuilder: (_, i) => Divider(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
