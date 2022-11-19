import 'package:flutter/material.dart';

class Swipeable extends StatefulWidget {
  final Widget child;
  final Function onSwipe;

  const Swipeable({
    Key? key,
    required this.child,
    required this.onSwipe,
  }) : super(key: key);

  @override
  State<Swipeable> createState() => _SwipeableState();
}

class _SwipeableState extends State<Swipeable> {
  Offset offset = Offset(0, 0);

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: offset,
      child: GestureDetector(
        onVerticalDragUpdate: (details) {
          setState(() {
            offset = offset + details.delta;
          });
        },
        onVerticalDragEnd: (details) {
          if (details.velocity.pixelsPerSecond.dy.abs() > 100) {
            widget.onSwipe();
          } else {
            setState(() {
              offset = Offset(0, 0);
            });
          }
        },
        child: widget.child,
      ),
    );
  }
}
