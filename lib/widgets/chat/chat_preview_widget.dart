import 'package:ensa/blocs/user_bloc.dart';
import 'package:ensa/graphql/graphql_api.dart';
import 'package:ensa/models/chat_model.dart';
import 'package:ensa/screens/chat/chat_screen.dart';
import 'package:ensa/utils/constants.dart';
import 'package:ensa/widgets/core/utility/user_avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatPreview extends StatelessWidget {
  const ChatPreview(this._chat, {Key? key}) : super(key: key);

  final ChatMixin _chat;

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
        leading: UserAvatar(
            avatarPath: getOtherUser().avatar?.filePath, radius: 32.5),
        title: Text(
          _chat.users[0].fullName,
          style: Theme.of(context).textTheme.headline4,
        ),
        subtitle: _chat.lastMessage != null
            ? Text(
                _chat.lastMessage!.text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
            : null,
        trailing: _chat.lastMessage != null
            ? Text(
                timeago.format(_chat.lastMessage!.createdAt),
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(color: Theme.of(context).accentColor),
              )
            : null,
      ),
    );
  }

  PublicUserMixin getOtherUser() {
    return _chat.users
        .firstWhere((element) => element.id != userBloc.currentUser.value!.id);
  }
}
