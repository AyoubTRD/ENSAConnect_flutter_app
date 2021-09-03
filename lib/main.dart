import 'package:ensa/screens/introduction_screen.dart';
import 'package:ensa/screens/main_screen.dart';
import 'package:ensa/screens/notifications_screen.dart';
import 'package:ensa/screens/signin_screen.dart';
import 'package:ensa/screens/signup_screen.dart';
import 'package:ensa/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ENSA',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: kPrimaryColor,
        accentColor: kAccentColor,
        fontFamily: 'Magdelin Alt',
        textTheme: TextTheme(
          headline1: TextStyle(
            color: kTextPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 50.0,
          ),
          headline2: TextStyle(
            color: kTitleText,
            fontWeight: FontWeight.w600,
            fontSize: 50.0,
          ),
          headline3: TextStyle(
            color: kTextPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 32.0,
          ),
          headline4: TextStyle(
            color: kTitleText,
            fontWeight: FontWeight.w600,
            fontSize: 20.0,
          ),
          bodyText2: TextStyle(
            color: kTextSecondary,
            fontSize: 18.0,
            height: 1.2,
            fontWeight: FontWeight.w500,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(kPrimaryColor),
            elevation: MaterialStateProperty.all(0.0),
            padding: MaterialStateProperty.all(
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
            ),
            textStyle: MaterialStateProperty.all(
              TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 16.0,
              ),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: kTitleText,
            fontWeight: FontWeight.w600,
            fontSize: 50.0,
          ),
        ),
      ),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return CupertinoPageRoute(builder: (_) => MainScreen());
          case '/welcome':
            return CupertinoPageRoute(builder: (_) => IntroductionScreen());
          case '/signup':
            return CupertinoPageRoute(builder: (_) => SignupScreen());
          case '/signin':
            return CupertinoPageRoute(builder: (_) => SigninScreen());
          case '/notifications':
            return CupertinoPageRoute(
                builder: (_) => NotificationsScreen(), fullscreenDialog: true);
        }
      },
      initialRoute: '/',
    );
  }
}
