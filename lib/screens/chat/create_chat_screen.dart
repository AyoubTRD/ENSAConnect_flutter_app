import 'package:ensa/blocs/chats_bloc.dart';
import 'package:ensa/blocs/user_bloc.dart';
import 'package:ensa/graphql/graphql_api.dart';
import 'package:ensa/screens/chat/chat_screen.dart';
import 'package:ensa/utils/constants.dart';
import 'package:ensa/widgets/core/app_bar_widget.dart';
import 'package:ensa/widgets/core/empty_state_widget.dart';
import 'package:ensa/widgets/core/utility/user_avatar_widget.dart';
import 'package:flutter/material.dart';

class CreateChatScreen extends StatefulWidget {
  static const routeName = '/chats/create';

  const CreateChatScreen({Key? key}) : super(key: key);

  @override
  State<CreateChatScreen> createState() => _CreateChatScreenState();
}

class _CreateChatScreenState extends State<CreateChatScreen> {
  String? _creatingChatForUserId;

  @override
  void initState() {
    super.initState();

    userBloc.getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        preferredSize: const Size.fromHeight(kToolbarHeight + 32.0),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation:
            Theme.of(context).brightness == Brightness.dark ? 16.0 : 10.0,
        shadowColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.black.withOpacity(0.2)
            : Colors.grey.shade900.withOpacity(0.1),
        centerTitle: true,
        title: Text(
          'Start a new chat',
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
            child: StreamBuilder<List<PublicUserMixin>>(
              stream: userBloc.publicUsers,
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    child: Text('Loading...'),
                  );

                if (snapshot.data!.isEmpty)
                  return EmptyState(text: 'No users available to chat with :(');

                return Column(
                  children: snapshot.data!
                      .where((element) =>
                          element.id != userBloc.currentUser.value!.id)
                      .toList()
                      .asMap()
                      .entries
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.only(bottom: 2.0),
                          child: _buildUserListItem(context, e.value),
                        ),
                      )
                      .toList(),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Future<void> _createChat(BuildContext context, PublicUserMixin user) async {
    setState(() {
      _creatingChatForUserId = user.id;
    });
    try {
      final loggedInUserId = userBloc.currentUser.value!.id;
      final chat = await chatsBloc.createChat(
        CreateChatInput(
          userIds: [loggedInUserId, user.id],
        ),
      );

      Navigator.of(context).popAndPushNamed(
        ChatScreen.routeName,
        arguments: ChatScreenArguments(chatId: chat.id),
      );
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Something went wrong!',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }

    setState(() {
      _creatingChatForUserId = null;
    });
  }

  Widget _buildUserListItem(BuildContext context, PublicUserMixin user) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0.5,
      child: InkWell(
        onTap: () => _createChat(context, user),
        child: Container(
          height: 75.0,
          padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding,
            vertical: 10.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  UserAvatar(
                    avatarPath: user.avatar?.filePath,
                    radius: 26.0,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    user.fullName,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1?.color,
                    ),
                  ),
                ],
              ),
              if (_creatingChatForUserId == user.id)
                SizedBox(
                  height: 20.0,
                  width: 20.0,
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
