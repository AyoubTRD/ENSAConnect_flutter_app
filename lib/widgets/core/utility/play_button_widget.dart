import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ionicons/ionicons.dart';

class PlayButton extends StatelessWidget {
  const PlayButton({Key? key, this.size = 50.0}) : super(key: key);

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size),
        color: Colors.white.withOpacity(0.8),
      ),
      child: Center(
        child: Icon(Ionicons.play_outline),
      ),
    );
  }
}
