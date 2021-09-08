import 'package:ensa/models/chat_model.dart';
import 'package:ensa/models/user_model.dart';
import 'package:ensa/utils/constants.dart';
import 'package:ensa/widgets/app_bar_widget.dart';
import 'package:ensa/widgets/chat_message_input_widget.dart';
import 'package:ensa/widgets/message_widget.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final Chat _chat = kChats[0];
  final User user = kUsers[2];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90.0),
        child: MyAppBar(
          elevation: 30.0,
          shadowColor: Colors.black.withOpacity(0.1),
          backgroundColor: Colors.white,
          showBackButton: true,
          centerTitle: false,
          title: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).accentColor.withOpacity(0.1),
              backgroundImage: NetworkImage(_chat.users[0].profilePicture),
              radius: 25.0,
            ),
            title: Text(
              _chat.users[0].fullName,
              maxLines: 1,
              style: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
                    fontSize: 18.0,
                  ),
            ),
            subtitle: Text(
              'online',
              style: TextStyle(color: Theme.of(context).accentColor),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  color: kAppBarText,
                  onPressed: () {},
                  icon: Icon(Ionicons.call_outline),
                ),
                IconButton(
                  color: kAppBarText,
                  onPressed: () {},
                  icon: Icon(Ionicons.ellipsis_vertical_outline),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            child: Expanded(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: _chat.messages.length,
                itemBuilder: (BuildContext context, int i) => Container(
                  margin: EdgeInsets.only(top: i == 0 ? kDefaultPadding : 0),
                  child: MessageWidget(_chat.messages[i]),
                ),
              ),
            ),
          ),
          ChatMessageInput(),
        ],
      ),
    );
  }
}
