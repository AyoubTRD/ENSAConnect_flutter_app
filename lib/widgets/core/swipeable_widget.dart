import 'package:flutter/material.dart';

class Swipeable extends StatefulWidget {
  final Widget child;
  final Function onSwipe;
  final bool disableScale;
  final bool disableBorderRadius;

  const Swipeable({
    Key? key,
    required this.child,
    required this.onSwipe,
    this.disableScale = false,
    this.disableBorderRadius = false,
  }) : super(key: key);

  @override
  State<Swipeable> createState() => _SwipeableState();
}

class _SwipeableState extends State<Swipeable> {
  Offset offset = Offset(0, 0);

  double get scale => (900 - offset.distance.abs()) / 900.0;
  double get borderRadius => (1 - scale) * 500;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: widget.disableScale ? 1.0 : scale,
      child: Transform.translate(
        offset: offset,
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              widget.disableBorderRadius ? 0.0 : borderRadius,
            ),
          ),
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
        ),
      ),
    );
  }
}
