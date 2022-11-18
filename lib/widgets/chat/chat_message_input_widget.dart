import 'package:ensa/utils/constants.dart';
import 'package:ensa/widgets/core/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class ChatMessageInput extends StatefulWidget {
  const ChatMessageInput({Key? key}) : super(key: key);

  @override
  _ChatMessageInputState createState() => _ChatMessageInputState();
}

class _ChatMessageInputState extends State<ChatMessageInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(kDefaultPadding),
      child: Stack(
        children: [
          Theme(
            data: Theme.of(context).copyWith(
              inputDecorationTheme:
                  Theme.of(context).inputDecorationTheme.copyWith(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 50.0,
                          vertical: 18.0,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
            ),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Type a message...',
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
            ),
          ),
          Positioned(
            left: 3.0,
            top: 3.0,
            child: IconButton(
              color: kTitleText,
              onPressed: () {},
              icon: Icon(Icons.emoji_emotions_outlined),
            ),
          ),
          Positioned(
            right: 3.0,
            top: 3.0,
            child: IconButton(
              color: kTextSecondary,
              onPressed: () {},
              icon: Icon(Icons.mic_none),
            ),
          ),
          Positioned(
            right: 30.0,
            top: 3.0,
            child: IconButton(
              color: kTextSecondary,
              onPressed: () {},
              icon: Icon(Ionicons.attach_outline),
            ),
          ),
        ],
      ),
    );
  }
}
