import 'package:ensa/models/message_model.dart';
import 'package:ensa/utils/constants.dart';
import 'package:flutter/material.dart';

class MessageWidget extends StatefulWidget {
  MessageWidget(this._m, {Key? key}) : super(key: key);

  final Message _m;

  @override
  _MessageWidgetState createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  late final bool isCurrentUser;

  @override
  void initState() {
    super.initState();
    setState(() {
      // TODO: Get isCurrentUser

      isCurrentUser = widget._m.user.id == kUsers[2].id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isCurrentUser ? Alignment.topRight : Alignment.topLeft,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(
          left: kDefaultPadding,
          right: kDefaultPadding,
          bottom: 10.0,
        ),
        child: isCurrentUser
            ? _buildMessageText(context)
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage:
                        NetworkImage(widget._m.user.profilePicture),
                    backgroundColor: Theme.of(context).accentColor,
                    radius: 26.0,
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  _buildMessageText(context)
                ],
              ),
      ),
    );
  }

  Widget _buildMessageText(BuildContext context) {
    const borderRadius = Radius.circular(25.0);

    return Column(
      crossAxisAlignment:
          isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
          width: isCurrentUser ? 300.0 : 250.0,
          decoration: BoxDecoration(
            color: isCurrentUser
                ? Theme.of(context).accentColor.withOpacity(0.11)
                : Colors.grey.shade100,
            borderRadius: BorderRadius.only(
              bottomLeft: !isCurrentUser ? Radius.zero : borderRadius,
              bottomRight: isCurrentUser ? Radius.zero : borderRadius,
              topRight: borderRadius,
              topLeft: borderRadius,
            ),
          ),
          child: Text(
            widget._m.text,
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  color: kTextPrimary,
                ),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          // TODO: Format the real message time
          '1:40 PM',
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                color: kTextSecondary,
              ),
        ),
      ],
    );
  }
}
