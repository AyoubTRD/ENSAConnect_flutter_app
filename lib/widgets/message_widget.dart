import 'package:ensa/models/message_model.dart';
import 'package:ensa/utils/constants.dart';
import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget(this._m, {Key? key}) : super(key: key);

  final Message _m;

  @override
  Widget build(BuildContext context) {
    final bool isCurrentUser = _m.user.id == kUsers[2].id;

    return Align(
      alignment: isCurrentUser ? Alignment.topRight : Alignment.topLeft,
      child: Container(
        color: isCurrentUser
            ? Theme.of(context).accentColor
            : Colors.grey.shade300,
        margin: EdgeInsets.only(
          left: kDefaultPadding,
          right: kDefaultPadding,
          bottom: kDefaultPadding,
        ),
        padding: EdgeInsets.symmetric(vertical: 3.0),
        child: Text(_m.text),
      ),
    );
  }
}
