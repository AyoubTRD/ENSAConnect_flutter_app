import 'dart:ui';

import 'package:ensa/blocs/posts_bloc.dart';
import 'package:ensa/screens/posts/uploaded_file_preview_widget.dart';
import 'package:ensa/services/rest_client_service.dart';
import 'package:ensa/utils/constants.dart';
import 'package:ensa/utils/types/uploaded_media_file.dart';
import 'package:ensa/widgets/core/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:collection/collection.dart';

class CreatePostScreen extends StatefulWidget {
  static const routeName = '/create-post';

  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  String _text = '';
  bool _isLoading = false;

  List<UploadedMediaFile> _files = [];

  bool get canSave =>
      (_text != '' || _files.isNotEmpty) &&
      _files.every((element) => !element.isUploading);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        preferredSize: const Size.fromHeight(kToolbarHeight + 32.0),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation:
            Theme.of(context).brightness == Brightness.dark ? 16.0 : 10.0,
        shadowColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.black.withOpacity(0.2)
            : Colors.grey.shade900.withOpacity(0.1),
        showBackButton: true,
        title: Text(
          'Create Post',
          style: Theme.of(context).textTheme.headline3,
        ),
        centerTitle: true,
        actions: [
          FittedBox(
            child: TextButton(
              onPressed: canSave ? handleSave : null,
              child: _isLoading
                  ? SizedBox(
                      width: 14.0,
                      height: 14.0,
                      child: CircularProgressIndicator(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.grey.shade900,
                      ),
                    )
                  : Opacity(
                      opacity: !canSave ? 0.5 : 1.0,
                      child: Text(
                        'Done',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
              style: ButtonStyle(
                overlayColor: MaterialStateColor.resolveWith(
                  (states) => Theme.of(context).brightness == Brightness.dark
                      ? Colors.white.withOpacity(0.1)
                      : Theme.of(context).primaryColor.withOpacity(0.1),
                ),
                foregroundColor: MaterialStateColor.resolveWith(
                  (states) => Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.grey.shade900,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: TextFormField(
              maxLines: null,
              onChanged: (val) {
                setState(() {
                  _text = val;
                });
              },
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Colors.transparent,
                hintText: "What's on your mind?",
                hintStyle: Theme.of(context).textTheme.headline4?.copyWith(
                      color: Theme.of(context)
                          .textTheme
                          .headline4
                          ?.color
                          ?.withOpacity(0.3),
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: kDefaultPadding),
            child: SizedBox(
              height: UploadedFilePreview.uploadedFilePreviewHeight,
              child: ReorderableListView.builder(
                onReorder: handleFilesReorder,
                proxyDecorator: (child, index, animation) => AnimatedBuilder(
                  animation: animation,
                  builder: (context, child) {
                    final animValue =
                        Curves.easeInOut.transform(animation.value);
                    final double scale = lerpDouble(1, 1.2, animValue)!;

                    return Transform.scale(
                      scale: scale,
                      child: child,
                    );
                  },
                  child: child,
                ),
                itemBuilder: (context, index) => Container(
                  key: Key(_files[index].file.hashCode.toString()),
                  margin: const EdgeInsets.only(
                    right: kDefaultPadding,
                  ),
                  child: UploadedFilePreview(
                    _files[index],
                    onRemove: () => handleRemoveUploadedFile(index),
                  ),
                ),
                header: const SizedBox(width: kDefaultPadding),
                itemCount: _files.length,
                scrollDirection: Axis.horizontal,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              kDefaultPadding,
              kDefaultPadding,
              kDefaultPadding,
              2 * kDefaultPadding,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: renderMediaButton(
                    onTap: handleUploadFromGallery,
                    context: context,
                    icon: Ionicons.images_outline,
                    text: 'Gallery',
                  ),
                ),
                SizedBox(
                  width: kDefaultPadding,
                ),
                Expanded(
                  child: renderMediaButton(
                    context: context,
                    icon: Ionicons.attach_outline,
                    text: 'Attachment',
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget renderMediaButton({
    required BuildContext context,
    required IconData icon,
    required String text,
    void Function()? onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(8.0),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white.withOpacity(0.25)
                  : Colors.black.withOpacity(0.25),
              style: BorderStyle.solid,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          height: 44.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding / 2.0,
            ),
            child: Center(
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: Theme.of(context).textTheme.bodyText1?.color,
                  ),
                  SizedBox(
                    width: 16.0,
                  ),
                  Transform.translate(
                    offset: Offset(0, 2.0),
                    child: Text(
                      text,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void handleFilesReorder(int oldIndex, int newIndex) {
    setState(() {
      final temp = _files[oldIndex];
      _files.removeAt(oldIndex);
      _files.insert(newIndex > oldIndex ? newIndex - 1 : newIndex, temp);
    });
  }

  Future<void> handleSave() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final List<String> files = [];
      _files.forEach((element) {
        files.add(element.path!);
      });
      await postsBloc.createPost(text: _text, files: files);
      Navigator.of(context).pop();
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Something went wrong!'),
        ),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> handleUploadFromGallery() async {
    try {
      final picker = ImagePicker();
      final images = await picker.pickMultiImage();

      if (images.isEmpty) return;

      List<UploadedMediaFile> files = List.from(_files);
      for (int i = 0; i < images.length; i++) {
        files.add(
          UploadedMediaFile(
            type: MediaType.IMAGE,
            file: images[i],
            isUploading: true,
            bytes: await images[i].readAsBytes(),
          ),
        );
      }

      setState(() {
        _files = files;
      });

      for (int i = 0; i < images.length; i++) {
        final url = await restClientService.uploadFile(images[i]);

        setState(() {
          final UploadedMediaFile? uploadedFile =
              _files.firstWhereOrNull((element) => element.file == images[i]);

          if (uploadedFile == null) return;
          uploadedFile.isUploading = false;
          uploadedFile.path = url;
        });
      }
    } catch (e) {
      print(e);

      const snackBar = SnackBar(
        content: Text(
          'An error has ocurred!',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void handleRemoveUploadedFile(int index) {
    final List<UploadedMediaFile> files = List.from(_files);
    files.removeAt(index);
    setState(() {
      _files = files;
    });
  }
}
