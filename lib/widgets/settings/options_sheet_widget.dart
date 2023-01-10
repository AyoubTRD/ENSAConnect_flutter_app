import 'package:flutter/material.dart';

class OptionsSheet extends StatelessWidget {
  const OptionsSheet({
    Key? key,
    required this.children,
  }) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      padding: EdgeInsets.symmetric(vertical: 14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Column(
        children: children,
      ),
    );
  }
}
