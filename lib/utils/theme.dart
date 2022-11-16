import 'package:ensa/utils/constants.dart';
import 'package:flutter/material.dart';

final theme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  primaryColor: kPrimaryColor,
  accentColor: kAccentColor,
  fontFamily: 'Magdelin Alt',
  textTheme: const TextTheme(
    headline1: const TextStyle(
      color: kTextPrimary,
      fontWeight: FontWeight.w600,
      fontSize: 50.0,
    ),
    headline2: const TextStyle(
      color: kTitleText,
      fontWeight: FontWeight.w600,
      fontSize: 50.0,
    ),
    headline3: const TextStyle(
      color: kAppBarText,
      fontWeight: FontWeight.w600,
      fontSize: 32.0,
    ),
    headline4: const TextStyle(
      color: kTitleText,
      fontWeight: FontWeight.w600,
      fontSize: 20.0,
    ),
    bodyText1: const TextStyle(
      color: kTextPrimary,
      fontSize: 16.0,
      height: 1.0,
      fontWeight: FontWeight.w500,
    ),
    bodyText2: const TextStyle(
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
);
