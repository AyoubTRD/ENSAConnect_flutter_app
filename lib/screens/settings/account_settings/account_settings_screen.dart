import 'package:ensa/blocs/user_bloc.dart';
import 'package:ensa/graphql/graphql_api.dart';
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
