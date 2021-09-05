import 'package:ensa/utils/constants.dart';
import 'package:flutter/material.dart';

class ChatPreview extends StatelessWidget {
  const ChatPreview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.0,
      width: double.infinity,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).accentColor.withOpacity(0.1),
          radius: 30.0,
          backgroundImage: NetworkImage(users[0].profilePicture),
        ),
        title: Text(
          users[0].fullName,
          style: Theme.of(context).textTheme.headline4,
        ),
        subtitle: Text(
          'lorem ipsum dolor is llsado sdasdfo asdasopf fobnnsdf sadnfe weiffh ',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Text(
          '22:10',
          style: Theme.of(context)
              .textTheme
              .bodyText1
              ?.copyWith(color: Theme.of(context).accentColor),
        ),
      ),
    );
  }
}
