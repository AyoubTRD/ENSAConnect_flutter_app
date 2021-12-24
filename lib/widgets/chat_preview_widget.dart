import 'package:ensa/models/chat_model.dart';
import 'package:ensa/screens/chat_screen.dart';
import 'package:ensa/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatPreview extends StatelessWidget {
  const ChatPreview(this._chat, {Key? key}) : super(key: key);

  final Chat _chat;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75.0,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        onTap: () {
          Navigator.pushNamed(context, ChatScreen.routeName,
              arguments: ChatScreenArguments(chatId: _chat.id));
        },
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).accentColor.withOpacity(0.1),
          radius: 32.5,
          backgroundImage: NetworkImage(_chat.users[0].profilePicture),
        ),
        title: Text(
          _chat.users[0].fullName,
          style: Theme.of(context).textTheme.headline4,
        ),
        subtitle: Text(
          _chat.messages[0].text,
          style: TextStyle(
            fontWeight: FontWeight.normal,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Text(
          timeago.format(DateTime.parse(_chat.messages[0].createdAt)),
          style: Theme.of(context)
              .textTheme
              .bodyText1
              ?.copyWith(color: Theme.of(context).accentColor),
        ),
      ),
    );
  }
}
