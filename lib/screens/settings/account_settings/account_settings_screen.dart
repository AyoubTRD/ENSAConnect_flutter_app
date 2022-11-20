import 'package:ensa/blocs/user_bloc.dart';
import 'package:ensa/graphql/graphql_api.dart';
import 'package:ensa/screens/onboarding/introduction_screen.dart';
import 'package:ensa/screens/settings/account_settings/name_settings_screen.dart';
import 'package:ensa/screens/settings/account_settings/password_settings_screen.dart';
import 'package:ensa/utils/constants.dart';
import 'package:ensa/widgets/core/app_bar_widget.dart';
import 'package:ensa/widgets/settings/settings_item_widget.dart';
import 'package:ensa/widgets/settings/settings_section_widget.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class AccountSettingsScreen extends StatefulWidget {
  const AccountSettingsScreen({Key? key}) : super(key: key);

  static const routeName = '/settings/profile-settings';

  @override
  State<AccountSettingsScreen> createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  bool _isLoading = false;

  Future<void> confirmDelete() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
            'Are you sure you want to delete your account? This action is irreversible!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: handleDelete,
            style: ButtonStyle(
              foregroundColor: MaterialStateColor.resolveWith(
                (states) => Colors.red.shade400,
              ),
              overlayColor: MaterialStateColor.resolveWith(
                (states) => Colors.red.shade400.withOpacity(0.05),
              ),
            ),
            child: _isLoading
                ? SizedBox(
                    width: 18.0,
                    height: 18.0,
                    child: CircularProgressIndicator(
                      color: Colors.red.shade400,
                    ),
                  )
                : Text('Delete'),
          ),
        ],
      ),
    );
  }

  Future<void> handleDelete() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await userBloc.deleteSelf();
      Navigator.of(context).popAndPushNamed(IntroductionScreen.routeName);
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error has ocurred'),
        ),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        centerTitle: true,
        title: Text(
          'Account Settings',
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
        child: StreamBuilder<UserMixin?>(
            stream: userBloc.currentUser,
            builder: (context, snapshot) {
              if (snapshot.data == null)
                return Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                );
              final hasPhoneNumber = false;
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    SettingsSection(
                      title: 'PERSONAL INFORMATION',
                      children: [
                        SettingsItem(
                          title: 'Change First & Last Name',
                          icon: Ionicons.person_circle_outline,
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(NameSettingsScreen.routeName);
                          },
                        ),
                        SettingsItem(
                          title: !hasPhoneNumber
                              ? 'Add Phone Number'
                              : 'Update Phone Number',
                          icon: Ionicons.call_outline,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: kDefaultPadding,
                    ),
                    SettingsSection(
                      title: 'SECURITY',
                      children: [
                        SettingsItem(
                          title: 'Update Email Address',
                          icon: Ionicons.mail_outline,
                        ),
                        SettingsItem(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(PasswordSettingsScreen.routeName);
                          },
                          title: 'Change/Reset Password',
                          icon: Ionicons.lock_closed_outline,
                        ),
                        SettingsItem(
                          title: 'Notification Settings',
                          icon: Ionicons.notifications_outline,
                        ),
                        SettingsItem(
                          danger: true,
                          title: 'Delete Account',
                          icon: Ionicons.trash_outline,
                          hideChevron: true,
                          onTap: confirmDelete,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: kDefaultPadding,
                    ),
                    SettingsSection(
                      title: 'SCHOOL',
                      children: [
                        SettingsItem(
                          title: 'Change City',
                          icon: Ionicons.location_outline,
                        ),
                        SettingsItem(
                          title: 'Set Specialty & School Year',
                          icon: Ionicons.school_outline,
                        ),
                        SettingsItem(
                          title: 'Club Settings',
                          icon: Ionicons.people_circle_outline,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
