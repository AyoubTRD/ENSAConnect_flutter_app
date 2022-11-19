import 'package:ensa/blocs/user_bloc.dart';
import 'package:ensa/graphql/graphql_api.dart';
import 'package:ensa/screens/core/image_dialog_screen.dart';
import 'package:ensa/services/rest_client_service.dart';
import 'package:ensa/widgets/core/image_dialog_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:photo_view/photo_view.dart';

class ProfilePictureSettings extends StatefulWidget {
  const ProfilePictureSettings({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfilePictureSettings> createState() => _ProfilePictureSettingsState();
}

class _ProfilePictureSettingsState extends State<ProfilePictureSettings> {
  bool _isLoading = false;

  Future<void> handleUpload(ImageSource source) async {
    _isLoading = true;

    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: source);

      if (image == null) return;

      final profilePicture = await restClientService.uploadFile(image);

      await userBloc.updateProfilePicture(profilePicture);
    } catch (e) {
      print(e);
      const snackBar = SnackBar(
        content: Text('An error has ocurred'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: ((context, AsyncSnapshot<UserMixin?> snapshot) {
        if (!snapshot.hasData) return Column();
        final avatar = snapshot.data?.avatar;
        final hasAvatar = avatar != null && avatar != '';
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(50.0),
                  onTap: (!hasAvatar || _isLoading)
                      ? null
                      : () {
                          Navigator.of(context).pushNamed(
                            ImageDialogScreen.routeName,
                            arguments: ImageDialogScreenArguments(
                              NetworkImage(avatar!),
                              heroAttributes: PhotoViewHeroAttributes(
                                tag: 'settings-avatar',
                              ),
                              path: avatar,
                              savable: true,
                            ),
                          );
                        },
                  child: Hero(
                    tag: 'settings-avatar',
                    child: CircleAvatar(
                      foregroundImage:
                          (hasAvatar) ? NetworkImage(avatar!) : null,
                      backgroundColor: Colors.grey.shade200,
                      child: !hasAvatar
                          ? Icon(
                              Ionicons.person,
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.8),
                              size: 28.0,
                            )
                          : null,
                      radius: 32.0,
                    ),
                  ),
                ),
                Material(
                  color: Theme.of(context).primaryColor.withOpacity(0.95),
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  child: InkWell(
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    onTap: () => handleUpload(ImageSource.camera),
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(
                        Ionicons.camera_outline,
                        size: 15.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
            TextButton(
              onPressed: () => handleUpload(ImageSource.gallery),
              child: Text(
                hasAvatar ? 'Update Picture' : 'Upload Picture',
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontSize: 15.0,
                    ),
              ),
            )
          ],
        );
      }),
      stream: userBloc.currentUser,
    );
  }
}
