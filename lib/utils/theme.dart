import 'package:ensa/blocs/preferences_bloc.dart';
import 'package:ensa/utils/constants.dart';
import 'package:flutter/material.dart';

ThemeData _getLightTheme(Color primaryColor) => ThemeData(
      scaffoldBackgroundColor: Colors.white,
      primaryColor: primaryColor,
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
          backgroundColor: MaterialStateProperty.resolveWith<Color>((state) {
            if (state.contains(MaterialState.disabled))
              return primaryColor.withOpacity(0.15);
            return primaryColor;
          }),
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
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateColor.resolveWith(
            (states) => primaryColor,
          ),
          overlayColor: MaterialStateColor.resolveWith(
            (states) => primaryColor.withOpacity(0.05),
          ),
        ),
      ),
      switchTheme: SwitchThemeData(
          overlayColor: MaterialStateColor.resolveWith((states) {
        if (states.contains(MaterialState.disabled))
          return Colors.grey.shade400.withOpacity(0.2);
        if (states.contains(MaterialState.error))
          return Colors.red.withOpacity(0.2);
        if (states.contains(MaterialState.selected))
          return primaryColor.withOpacity(0.2);
        else
          return Colors.grey.shade500.withOpacity(0.2);
      }), trackColor: MaterialStateColor.resolveWith((states) {
        if (states.contains(MaterialState.disabled))
          return Colors.grey.shade400.withOpacity(0.70);
        if (states.contains(MaterialState.error))
          return Colors.red.withOpacity(0.70);
        if (states.contains(MaterialState.selected))
          return primaryColor.withOpacity(0.70);
        else
          return Colors.grey.shade500.withOpacity(0.70);
      }), thumbColor: MaterialStateColor.resolveWith((states) {
        if (states.contains(MaterialState.disabled))
          return Colors.grey.shade400;
        if (states.contains(MaterialState.error)) return Colors.red;
        if (states.contains(MaterialState.selected))
          return primaryColor.withOpacity(0.9);
        else
          return Colors.white;
      })),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
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

ThemeData _getDarkTheme(Color primaryColor) => ThemeData(
      scaffoldBackgroundColor: Colors.black,
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      accentColor: kAccentColor,
      fontFamily: 'Magdelin Alt',
      textTheme: const TextTheme(
        headline1: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 50.0,
        ),
        headline2: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 50.0,
        ),
        headline3: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 32.0,
        ),
        headline4: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 20.0,
        ),
        bodyText1: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
          height: 1.0,
          fontWeight: FontWeight.w500,
        ),
        bodyText2: const TextStyle(
          color: Colors.white,
          fontSize: 18.0,
          height: 1.2,
          fontWeight: FontWeight.w500,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>((state) {
            if (state.contains(MaterialState.disabled))
              return primaryColor.withOpacity(0.15);
            return primaryColor;
          }),
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
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateColor.resolveWith(
            (states) => primaryColor,
          ),
          overlayColor: MaterialStateColor.resolveWith(
            (states) => primaryColor.withOpacity(0.05),
          ),
        ),
      ),
      switchTheme: SwitchThemeData(
          overlayColor: MaterialStateColor.resolveWith((states) {
        if (states.contains(MaterialState.disabled))
          return Colors.grey.shade400.withOpacity(0.2);
        if (states.contains(MaterialState.error))
          return Colors.red.withOpacity(0.2);
        if (states.contains(MaterialState.selected))
          return primaryColor.withOpacity(0.2);
        else
          return Colors.grey.shade500.withOpacity(0.2);
      }), trackColor: MaterialStateColor.resolveWith((states) {
        if (states.contains(MaterialState.disabled))
          return Colors.grey.shade400.withOpacity(0.70);
        if (states.contains(MaterialState.error))
          return Colors.red.withOpacity(0.70);
        if (states.contains(MaterialState.selected))
          return primaryColor.withOpacity(0.70);
        else
          return Colors.grey.shade500.withOpacity(0.70);
      }), thumbColor: MaterialStateColor.resolveWith((states) {
        if (states.contains(MaterialState.disabled))
          return Colors.grey.shade400;
        if (states.contains(MaterialState.error)) return Colors.red;
        if (states.contains(MaterialState.selected))
          return primaryColor.withOpacity(0.9);
        else
          return Colors.white;
      })),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 50.0,
        ),
      ),
    );

final Map<int, ThemeData> themeCollection = {};

void loadThemeCollection() {
  for (int i = 0; i < themeColors.length; i++) {
    themeCollection.putIfAbsent(i, () => _getLightTheme(themeColors[i]));
    themeCollection.putIfAbsent(
        themeColors.length + i, () => _getDarkTheme(themeColors[i]));
  }
}

int getLightThemeKey(Color color) {
  return themeColors.indexOf(color);
}

int getDarkThemeKey(Color color) {
  return themeColors.length + themeColors.indexOf(color);
}
