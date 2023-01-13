import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:ensa/blocs/preferences_bloc.dart';
import 'package:ensa/blocs/user_bloc.dart';
import 'package:ensa/screens/chat/chat_screen.dart';
import 'package:ensa/screens/core/image_dialog_screen.dart';
import 'package:ensa/screens/onboarding/introduction_screen.dart';
import 'package:ensa/screens/core/main_screen.dart';
import 'package:ensa/screens/notifications/notifications_screen.dart';
import 'package:ensa/screens/onboarding/signin_screen.dart';
import 'package:ensa/screens/onboarding/signup_screen.dart';
import 'package:ensa/screens/posts/post_form_screen.dart';
import 'package:ensa/screens/settings/account_settings/account_settings_screen.dart';
import 'package:ensa/screens/settings/account_settings/name_settings_screen.dart';
import 'package:ensa/screens/settings/account_settings/password_settings_screen.dart';
import 'package:ensa/screens/settings/account_settings/phone_number_settings_screen.dart';
import 'package:ensa/screens/settings/app_appearance/app_appearance_screen.dart';
import 'package:ensa/utils/preferences_instant.dart';
import 'package:ensa/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:intl/intl.dart';

void main() async {
  Intl.defaultLocale = 'en_us';

  WidgetsFlutterBinding.ensureInitialized();
  await loadSharedPreferencesInstance();

  await FlutterLibphonenumber().init();

  preferencesBloc.init();
  loadThemeCollection();

  runApp(ENSAConnect());
}

class ENSAConnect extends StatelessWidget {
  const ENSAConnect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      builder: (BuildContext context, ThemeData theme) => MaterialApp(
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
            case PostFormScreen.routeName:
              final args = settings.arguments as PostFormScreenArguments?;
              return CupertinoPageRoute(
                builder: (_) => PostFormScreen(
                  feedPost: args?.feedPost,
                ),
                fullscreenDialog: true,
              );
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
            case AppAppearanceScreen.routeName:
              return CupertinoPageRoute(builder: (_) => AppAppearanceScreen());
            case AccountSettingsScreen.routeName:
              return CupertinoPageRoute(
                  builder: (_) => AccountSettingsScreen());
            case NameSettingsScreen.routeName:
              return CupertinoPageRoute(builder: (_) => NameSettingsScreen());
            case PasswordSettingsScreen.routeName:
              return CupertinoPageRoute(
                  builder: (_) => PasswordSettingsScreen());
            case PhoneNumberSettingsScreen.routeName:
              return CupertinoPageRoute(
                  builder: (_) => PhoneNumberSettingsScreen());
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
      ),
      themeCollection: ThemeCollection(
        fallbackTheme: themeCollection[0],
        themes: themeCollection,
      ),
    );
  }
}
