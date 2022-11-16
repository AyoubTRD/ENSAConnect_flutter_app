import 'package:ensa/blocs/auth_bloc.dart';
import 'package:ensa/screens/chat_screen.dart';
import 'package:ensa/screens/introduction_screen.dart';
import 'package:ensa/screens/main_screen.dart';
import 'package:ensa/screens/notifications_screen.dart';
import 'package:ensa/screens/signin_screen.dart';
import 'package:ensa/screens/signup_screen.dart';
import 'package:ensa/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: authBloc.isReady,
      builder: (context, snapshot) {
        return MaterialApp(
          title: 'ENSA Connect',
          theme: theme,
          initialRoute: IntroductionScreen.routeName,
          onGenerateRoute: (RouteSettings settings) {
            const protectedRoutes = [
              MainScreen.routeName,
              NotificationsScreen.routeName,
              ChatScreen.routeName
            ];
            if (authBloc.isReady.value &&
                !authBloc.isAuthenticated.value &&
                protectedRoutes.contains(settings.name)) {
              print('We are rendering the unauthenticated app');
              return CupertinoPageRoute(builder: (_) => IntroductionScreen());
            }
            print('We are rendering the authenticated app');
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
            }
          },
        );
      },
    );
  }
}
