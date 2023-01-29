import 'package:ensa/blocs/chats_bloc.dart';
import 'package:ensa/blocs/user_bloc.dart';
import 'package:ensa/graphql/graphql_api.dart';
import 'package:ensa/models/chat_model.dart';
import 'package:ensa/models/user_model.dart';
import 'package:ensa/utils/constants.dart';
import 'package:ensa/widgets/core/app_bar_widget.dart';
import 'package:ensa/widgets/chat/chat_message_input_widget.dart';
import 'package:ensa/widgets/chat/message_widget.dart';
import 'package:ensa/widgets/core/empty_state_widget.dart';
import 'package:ensa/widgets/core/utility/user_avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:rxdart/rxdart.dart';

class ChatScreen extends StatefulWidget {
  static const routeName = '/chat';
  final String chatId;
  const ChatScreen({Key? key, required this.chatId}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class ChatScreenArguments {
  final String chatId;
  ChatScreenArguments({required this.chatId});
}

class _ChatScreenState extends State<ChatScreen> {
  final UserMixin user = userBloc.currentUser.value!;

  @override
  void initState() {
    super.initState();

    chatsBloc.getMessagesForChat(widget.chatId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90.0),
        child: FutureBuilder<ChatMixin>(
            future: chatsBloc.getChatById(widget.chatId),
            builder: (context, snapshot) {
              final loaded = snapshot.hasData;
              final chat = snapshot.data;
              return MyAppBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                elevation: Theme.of(context).brightness == Brightness.dark
                    ? 16.0
                    : 10.0,
                shadowColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.black.withOpacity(0.2)
                    : Colors.grey.shade900.withOpacity(0.1),
                showBackButton: true,
                centerTitle: false,
                title: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: UserAvatar(
                    avatarPath: getOtherUser(chat!).avatar?.filePath,
                    radius: 25.0,
                  ),
                  title: Text(
                    loaded ? getOtherUser(chat!).fullName : "Loading...",
                    maxLines: 1,
                    style:
                        Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
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
              );
            }),
      ),
      body: FutureBuilder<ChatMixin>(
          future: chatsBloc.getChatById(widget.chatId),
          builder: (context, snapshot) {
            final chat = snapshot.data;
            final otherUser = chat != null ? getOtherUser(chat) : null;
            return Column(
              children: [
                Container(
                  child: Expanded(
                    child: StreamBuilder<List<MessageMixin>?>(
                        stream: chatsBloc.chatMessages
                            .map((event) => event[widget.chatId]),
                        builder: (context, snapshot) {
                          if (snapshot.data == null) return Container();
                          final messages = snapshot.data!;

                          if (messages.length == 0)
                            return Padding(
                              padding:
                                  const EdgeInsets.only(top: kDefaultPadding),
                              child: EmptyState(
                                text: "Start by sending your first message",
                              ),
                            );

                          return ListView.builder(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: messages.length,
                            reverse: true,
                            itemBuilder: (BuildContext context, int i) =>
                                Container(
                              margin: EdgeInsets.only(
                                top: i == 0 ? kDefaultPadding : 0,
                              ),
                              child: MessageWidget(
                                messages[i],
                                otherUser: (otherUser as PublicUserMixin),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
                ChatMessageInput(
                  chatId: widget.chatId,
                ),
              ],
            );
          }),
    );
  }

  PublicUserMixin getOtherUser(ChatMixin chat) {
    return chat.users
        .firstWhere((element) => element.id != userBloc.currentUser.value?.id);
  }
}
