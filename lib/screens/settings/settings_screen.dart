import 'package:ensa/blocs/user_bloc.dart';
import 'package:ensa/screens/notifications/notifications_screen.dart';
import 'package:ensa/screens/settings/account_settings/account_settings_screen.dart';
import 'package:ensa/screens/settings/app_appearance/app_appearance_screen.dart';
import 'package:ensa/utils/constants.dart';
import 'package:ensa/widgets/core/app_bar_widget.dart';
import 'package:ensa/widgets/settings/profile_picture_settings_widget.dart';
import 'package:ensa/widgets/settings/settings_item_widget.dart';
import 'package:ensa/widgets/settings/settings_section_widget.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        centerTitle: true,
        showBackButton: false,
        title: Text(
          'My Account',
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(height: kDefaultPadding / 2.0),
            ProfilePictureSettings(),
            SizedBox(
              height: kDefaultPadding,
            ),
            SettingsSection(
              title: 'ACCOUNT',
              children: [
                SettingsItem(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(AccountSettingsScreen.routeName);
                  },
                  title: 'Account Settings',
                  icon: Ionicons.person_outline,
                ),
                SettingsItem(
                  onTap: () {
                    userBloc.logout();
                    Navigator.of(context)
                        .popAndPushNamed(NotificationsScreen.routeName);
                  },
                  title: 'Logout',
                  icon: Ionicons.log_out_outline,
                  hideChevron: true,
                ),
              ],
            ),
            SizedBox(
              height: 2 * kDefaultPadding,
            ),
            SettingsSection(
              children: [
                SettingsItem(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(AppAppearanceScreen.routeName);
                  },
                  title: 'App Appearance',
                  icon: Ionicons.bulb_outline,
                ),
                SettingsItem(
                  title: 'Terms & Conditions',
                  icon: Ionicons.newspaper_outline,
                ),
                SettingsItem(
                  title: 'Help & Support',
                  icon: Ionicons.help_circle_outline,
                )
              ],
              title: 'OTHERS',
            ),
          ],
        ),
      ),
    );
  }
}
