import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageDialog extends StatelessWidget {
  const ImageDialog({Key? key, required this.imageProvider}) : super(key: key);

  final ImageProvider imageProvider;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: PhotoView(
        imageProvider: imageProvider,
        tightMode: true,
      ),
    );
  }
}
