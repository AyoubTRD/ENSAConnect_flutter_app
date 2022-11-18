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
            color: Colors.grey.shade900.withOpacity(0.05),
          )
        ],
        color: Colors.white,
      ),
      margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      padding: EdgeInsets.symmetric(vertical: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 12.0, bottom: 6.0),
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
