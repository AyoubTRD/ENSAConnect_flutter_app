import 'dart:ui';

import 'package:ensa/blocs/posts_bloc.dart';
import 'package:ensa/graphql/graphql_api.dart';
import 'package:ensa/screens/posts/uploaded_file_preview_widget.dart';
import 'package:ensa/services/rest_client_service.dart';
import 'package:ensa/utils/constants.dart';
import 'package:ensa/utils/types/uploaded_media_file.dart';
import 'package:ensa/widgets/core/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:collection/collection.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class PostFormScreenArguments {
  final FeedPostMixin? feedPost;

  const PostFormScreenArguments({this.feedPost});
}

class PostFormScreen extends StatefulWidget {
  static const routeName = '/post-form';

  PostFormScreen({Key? key, this.feedPost}) : super(key: key);

  final FeedPostMixin? feedPost;

  @override
  State<PostFormScreen> createState() => _PostFormScreenState();
}

class _PostFormScreenState extends State<PostFormScreen> {
  bool get isEditMode => widget.feedPost != null;

  bool get canSave =>
      (_text != '' || _files.isNotEmpty) &&
      _files.every((element) => !element.isUploading);

  late String _text;
  late List<UploadedMediaFile> _files;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      if (isEditMode) {
        _text = widget.feedPost!.text;
        _files = widget.feedPost!.files
            .map((e) => UploadedMediaFile(
                  type: e.fileType,
                  isUploading: false,
                  path: e.fileType == MediaFileType.image
                      ? e.filePath
                      : e.thumbnailPath,
                  fileId: e.id,
                ))
            .toList();
      } else {
        _text = '';
        _files = [];
      }
    });
  }

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
          isEditMode ? 'Edit Post' : 'Create Post',
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
              initialValue: _text,
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
                  key: Key(_files[index].hashCode.toString()),
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
                    onTap: () => handleUploadFromGallery(context),
                    context: context,
                    icon: Ionicons.images_outline,
                    text: 'Images',
                  ),
                ),
                SizedBox(
                  width: kDefaultPadding,
                ),
                Expanded(
                  child: renderMediaButton(
                    context: context,
                    icon: Ionicons.attach_outline,
                    text: 'Attachments',
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
        files.add(element.fileId!);
      });
      if (isEditMode) {
        await postsBloc.updatePost(
            postId: widget.feedPost!.id, text: _text, fileIds: files);
      } else {
        await postsBloc.createPost(text: _text, fileIds: files);
      }
      Navigator.of(context).pop();
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Something went wrong!',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> handleUploadFromGallery(BuildContext context) async {
    try {
      // final picker = ImagePicker();
      final assets = await AssetPicker.pickAssets(context);

      if (assets == null || assets.isEmpty) return;

      List<UploadedMediaFile> files = List.from(_files);
      for (int i = 0; i < assets.length; i++) {
        if (assets[i].type == AssetType.image) {
          files.add(
            UploadedMediaFile(
              entity: assets[i],
              type: MediaFileType.image,
              isUploading: true,
              bytes: await assets[i].originBytes,
            ),
          );
        } else if (assets[i].type == AssetType.video) {
          files.add(
            UploadedMediaFile(
              type: MediaFileType.video,
              isUploading: true,
              entity: assets[i],
              bytes: await assets[i].thumbnailData,
            ),
          );
        }
      }

      setState(() {
        _files = files;
      });

      for (int i = 0; i < assets.length; i++) {
        final file = await restClientService.uploadAssetEntity(
          assets[i],
          type: assets[i].type == AssetType.video
              ? MediaFileType.video
              : MediaFileType.image,
        );

        setState(() {
          final UploadedMediaFile? uploadedFile = _files.firstWhereOrNull(
            (element) => element.entity!.id == assets[i].id,
          );

          if (uploadedFile == null) return;
          uploadedFile.isUploading = false;
          uploadedFile.path = file.filePath;
          uploadedFile.fileId = file.id;
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
