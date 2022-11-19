import 'package:ensa/utils/constants.dart';
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

class ImageDialogScreen extends StatelessWidget {
  static const routeName = '/full-screen-image-dialog';

  const ImageDialogScreen({
    Key? key,
    required this.args,
  }) : super(key: key);

  final ImageDialogScreenArguments args;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onLongPress: () {
          if (!args.savable) return;
          showModalBottomSheet(
            context: context,
            builder: (context) => Container(
              padding: EdgeInsets.symmetric(vertical: kDefaultPadding),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: [
                  if (args.savable)
                    SettingsItem(
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
                      title: 'Save Image',
                      icon: Ionicons.download_outline,
                    )
                ],
              ),
            ),
          );
        },
        child: PhotoView(
          backgroundDecoration: BoxDecoration(color: Colors.transparent),
          imageProvider: args.imageProvider,
          tightMode: true,
          heroAttributes: args.heroAttributes,
        ),
      ),
    );
  }
}
