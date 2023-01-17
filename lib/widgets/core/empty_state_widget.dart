import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  final String text;

  const EmptyState({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(text),
      ],
    );
  }
}
