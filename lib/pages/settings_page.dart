import 'package:ensa/blocs/auth_bloc.dart';
import 'package:ensa/graphql/graphql_api.dart';
import 'package:ensa/screens/notifications_screen.dart';
import 'package:ensa/utils/constants.dart';
import 'package:ensa/widgets/app_bar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(height: kDefaultPadding / 2.0),
          BasicSettings(),
          SizedBox(
            height: kDefaultPadding,
          ),
          SettingsSection(
            title: 'ACCOUNT',
            children: [
              SettingsItem(
                onTap: () {},
                title: 'Profile Settings',
                icon: Ionicons.person_outline,
              ),
              SettingsItem(
                onTap: () {
                  authBloc.logout();
                  Navigator.of(context)
                      .pushNamed(NotificationsScreen.routeName);
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
                onTap: () {},
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
    );
  }
}

class BasicSettings extends StatelessWidget {
  const BasicSettings({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: ((context, AsyncSnapshot<UserMixin?> snapshot) {
        print(snapshot.data);
        if (!snapshot.hasData) return Column();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  foregroundImage:
                      NetworkImage('https://picsum.photos/100/100'),
                  radius: 32.0,
                ),
                Material(
                  color: Theme.of(context).primaryColor.withOpacity(0.95),
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  child: InkWell(
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    onTap: () {},
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
            SizedBox(height: 8.0),
            Text(
              'Update Picture',
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    fontSize: 15.0,
                  ),
            )
          ],
        );
      }),
      stream: authBloc.currentUser,
    );
  }
}

class SettingsSection extends StatelessWidget {
  final List<Widget> children;
  final String title;

  const SettingsSection({Key? key, required this.children, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(6.0)),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 2.0),
            spreadRadius: 1.0,
            color: Colors.grey.shade900.withOpacity(0.05),
          )
        ],
        color: Colors.white,
      ),
      margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      padding: EdgeInsets.symmetric(vertical: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 12.0, bottom: 6.0),
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    letterSpacing: 1.2,
                  ),
            ),
          ),
          ...children,
        ],
      ),
    );
  }
}

class SettingsItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool hideChevron;
  final void Function()? onTap;

  const SettingsItem({
    required this.title,
    required this.icon,
    this.hideChevron = false,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Icon(
                  icon,
                  color: Theme.of(context).primaryColor,
                  size: 25.0,
                ),
              ),
              Transform.translate(
                offset: Offset(0.0, 2.0),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              if (!hideChevron) ...[
                Expanded(child: Container()),
                Icon(
                  Ionicons.chevron_forward_outline,
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(width: 12.0),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
