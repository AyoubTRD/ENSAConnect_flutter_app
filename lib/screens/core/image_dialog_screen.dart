import 'package:ensa/utils/constants.dart';
import 'package:ensa/widgets/core/swipeable_widget.dart';
import 'package:ensa/widgets/settings/options_sheet_widget.dart';
import 'package:ensa/widgets/settings/settings_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:ionicons/ionicons.dart';
import 'package:photo_view/photo_view.dart';

class ImageDialogScreenArguments {
  final ImageProvider imageProvider;
  final PhotoViewHeroAttributes? heroAttributes;
  final bool savable;
  final String? path;

  ImageDialogScreenArguments(
    this.imageProvider, {
    this.heroAttributes,
    this.savable = true,
    this.path,
  });
}

class ImageDialogScreen extends StatefulWidget {
  static const routeName = '/full-screen-image-dialog';

  const ImageDialogScreen({
    Key? key,
    required this.args,
  }) : super(key: key);

  final ImageDialogScreenArguments args;

  @override
  State<ImageDialogScreen> createState() => _ImageDialogScreenState();
}

class _ImageDialogScreenState extends State<ImageDialogScreen> {
  Offset offset = Offset(0, 0);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Swipeable(
        onSwipe: () {
          Navigator.of(context).pop();
        },
        child: GestureDetector(
          onLongPress: () {
            if (!widget.args.savable) return;
            showModalBottomSheet(
              context: context,
              builder: (context) => ImageOptionsSheet(args: widget.args),
            );
          },
          child: PhotoView(
            backgroundDecoration: BoxDecoration(color: Colors.transparent),
            imageProvider: widget.args.imageProvider,
            tightMode: true,
            heroAttributes: widget.args.heroAttributes,
          ),
        ),
      ),
    );
  }
}

class ImageOptionsSheet extends StatelessWidget {
  const ImageOptionsSheet({
    Key? key,
    required this.args,
  }) : super(key: key);

  final ImageDialogScreenArguments args;

  @override
  Widget build(BuildContext context) {
    return OptionsSheet(
      children: [
        if (args.savable)
          SettingsItem(
            forceDarkText: true,
            dense: false,
            onTap: () async {
              try {
                if (args.path == null) throw Error();
                await GallerySaver.saveImage(args.path!);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Image saved successfully!'),
                  ),
                );
              } catch (e) {
                print(e);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Failed to save image'),
                  ),
                );
              }
              Navigator.of(context).pop();
            },
            title: const Text('Save Image'),
            icon: Ionicons.download_outline,
          )
      ],
    );
  }
}
