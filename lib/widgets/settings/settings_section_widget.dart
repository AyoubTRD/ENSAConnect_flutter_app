import 'package:ensa/utils/constants.dart';
import 'package:flutter/material.dart';

class SettingsSection extends StatelessWidget {
  final List<Widget> children;
  final String title;

  const SettingsSection({Key? key, required this.title, required this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(6.0)),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 2.0),
            spreadRadius: 1.0,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white.withOpacity(0.10)
                : Colors.grey.shade900.withOpacity(0.05),
          )
        ],
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey.shade900.withOpacity(0.2)
            : Theme.of(context).scaffoldBackgroundColor,
      ),
      padding: EdgeInsets.symmetric(vertical: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 12.0, bottom: 6.0, top: 4.0),
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    letterSpacing: 1.2,
                  ),
            ),
          ),
          ...children,
        ],
      ),
    );
  }
}
