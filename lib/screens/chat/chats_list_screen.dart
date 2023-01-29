import 'package:ensa/blocs/chats_bloc.dart';
import 'package:ensa/graphql/graphql_api.dart';
import 'package:ensa/screens/chat/create_chat_screen.dart';
import 'package:ensa/screens/core/paged_screen.dart';
import 'package:ensa/utils/constants.dart';
import 'package:ensa/widgets/core/app_bar_widget.dart';
import 'package:ensa/widgets/chat/chat_preview_widget.dart';
import 'package:ensa/widgets/core/empty_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class ChatsListScreen extends StatefulWidget {
  static const routeName = '/chats';

  const ChatsListScreen({Key? key}) : super(key: key);

  @override
  State<ChatsListScreen> createState() => _ChatsListScreenState();
}

class _ChatsListScreenState extends State<ChatsListScreen> {
  @override
  void initState() {
    super.initState();

    chatsBloc.getAllChats();
  }

  @override
  Widget build(BuildContext context) {
    return PagedScreen(
      children: [
        Container(
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              SizedBox(height: kDefaultPadding / 2.0),
              SizedBox(
                height: 100.0,
                width: double.infinity,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  children: [
                    SizedBox(
                      width: kDefaultPadding,
                    ),
                    ...kUsers
                        .map(
                          (e) => Container(
                            margin: const EdgeInsets.only(
                              right: kDefaultPadding + 9.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 60.0,
                                  height: 60.0,
                                  child: CircleAvatar(
                                    backgroundColor: Theme.of(context)
                                        .accentColor
                                        .withOpacity(0.1),
                                    backgroundImage:
                                        NetworkImage(e.profilePicture),
                                  ),
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                Text(
                                  e.firstName,
                                  style: Theme.of(context).textTheme.bodyText1,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ],
                ),
              ),
              // SizedBox(
              // height: 10.0,
              // ),
              StreamBuilder<List<ChatMixin>>(
                stream: chatsBloc.chats,
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Padding(
                      padding: const EdgeInsets.all(kDefaultPadding),
                      child: Text("Loading..."),
                    );

                  if (snapshot.data!.isEmpty)
                    return Padding(
                      padding: const EdgeInsets.all(kDefaultPadding),
                      child: EmptyState(
                        text: "No chats available",
                      ),
                    );

                  return Column(
                    children: _buildChats(context, snapshot.data!),
                  );
                },
              )
            ],
          ),
        ),
      ],
      appBar: MyAppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        showBackButton: false,
        title: Text(
          'Chats',
          style: Theme.of(context).textTheme.headline3,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Ionicons.search_outline),
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : kAppBarText,
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(CreateChatScreen.routeName);
            },
            icon: Icon(Ionicons.create_outline),
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : kAppBarText,
          ),
        ],
      ),
      pageCount: 2,
      pageNames: ['Messages', 'Calls'],
    );
  }

  List<Widget> _buildChats(BuildContext context, List<ChatMixin> chats) {
    List<Widget> widgets = [];
    for (int i = 0; i < chats.length; i++) {
      widgets.add(ChatPreview(chats[i]));
      if (i != chats.length - 1) {
        widgets.add(
          Container(
            margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Divider(),
          ),
        );
      }
    }

    return widgets;
  }
}
