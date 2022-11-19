import 'package:ensa/blocs/user_bloc.dart';
import 'package:ensa/screens/chat/chat_screen.dart';
import 'package:ensa/screens/core/image_dialog_screen.dart';
import 'package:ensa/screens/onboarding/introduction_screen.dart';
import 'package:ensa/screens/core/main_screen.dart';
import 'package:ensa/screens/notifications/notifications_screen.dart';
import 'package:ensa/screens/onboarding/signin_screen.dart';
import 'package:ensa/screens/onboarding/signup_screen.dart';
import 'package:ensa/screens/settings/account_settings/account_settings_screen.dart';
import 'package:ensa/screens/settings/account_settings/name_settings_screen.dart';
import 'package:ensa/screens/settings/account_settings/password_settings_screen.dart';
import 'package:ensa/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() async {
  Intl.defaultLocale = 'en_us';

  WidgetsFlutterBinding.ensureInitialized();
  runApp(ENSAConnect());
}

class ENSAConnect extends StatelessWidget {
  const ENSAConnect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ENSA Connect',
      theme: theme,
      initialRoute: IntroductionScreen.routeName,
      onGenerateRoute: (RouteSettings settings) {
        const protectedRoutes = [
          MainScreen.routeName,
          NotificationsScreen.routeName,
          ChatScreen.routeName,
          AccountSettingsScreen.routeName,
        ];
        if (userBloc.isReady.value &&
            !userBloc.isAuthenticated.value &&
            protectedRoutes.contains(settings.name)) {
          return CupertinoPageRoute(builder: (_) => IntroductionScreen());
        }
        switch (settings.name) {
          case MainScreen.routeName:
            return CupertinoPageRoute(builder: (_) => MainScreen());
          case IntroductionScreen.routeName:
            return CupertinoPageRoute(builder: (_) => IntroductionScreen());
          case SignupScreen.routeName:
            return CupertinoPageRoute(builder: (_) => SignupScreen());
          case SigninScreen.routeName:
            return CupertinoPageRoute(builder: (_) => SigninScreen());
          case NotificationsScreen.routeName:
            return CupertinoPageRoute(
              builder: (_) => NotificationsScreen(),
              fullscreenDialog: true,
            );
          case ChatScreen.routeName:
            final args = settings.arguments as ChatScreenArguments;
            return CupertinoPageRoute(
              builder: (_) => ChatScreen(
                chatId: args.chatId,
              ),
            );
          case AccountSettingsScreen.routeName:
            return CupertinoPageRoute(builder: (_) => AccountSettingsScreen());
          case NameSettingsScreen.routeName:
            return CupertinoPageRoute(builder: (_) => NameSettingsScreen());
          case PasswordSettingsScreen.routeName:
            return CupertinoPageRoute(builder: (_) => PasswordSettingsScreen());
          case ImageDialogScreen.routeName:
            final args = settings.arguments as ImageDialogScreenArguments;
            return PageRouteBuilder(
              fullscreenDialog: true,
              opaque: false,
              barrierDismissible: true,
              barrierColor: Colors.black.withOpacity(0.3),
              pageBuilder: (_, __, ___) => ImageDialogScreen(args: args),
            );
        }
      },
    );
  }
}
