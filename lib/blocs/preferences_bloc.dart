import 'package:ensa/utils/constants.dart';
import 'package:ensa/utils/preferences_instant.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

const _themeModeKey = 'theme_mode_preference';
const _primaryColorKey = 'primary_color_preference';

enum ThemeModePreference {
  light,
  dark,
  system,
}

final List<Color> themeColors = [
  kPrimaryColor,
  Colors.teal.shade500,
  Colors.cyan.shade600,
  Colors.blue.shade700,
  Colors.indigo.shade600,
  Colors.deepPurple.shade600,
  Colors.purple,
  Colors.pink.shade600,
  Colors.deepOrange.shade600,
  Colors.orange.shade700,
  Colors.amber.shade600,
  Colors.lime.shade600,
  Colors.lightGreen.shade600,
  Colors.green.shade600,
];

class PreferencesBloc {
  BehaviorSubject<ThemeModePreference> _themeMode =
      BehaviorSubject.seeded(ThemeModePreference.system);
  BehaviorSubject<Color> _primaryColor = BehaviorSubject.seeded(kPrimaryColor);

  ValueStream<ThemeModePreference> get themeMode => _themeMode.stream;
  ValueStream<Color> get primaryColor => _primaryColor.stream;

  void init() {
    final savedThemeMode = prefsInstance.getString(_themeModeKey);
    final savedPrimaryColor = prefsInstance.getString(_primaryColorKey);

    if (savedThemeMode != null) {
      if (savedThemeMode == 'dark')
        _themeMode.sink.add(ThemeModePreference.dark);
      if (savedThemeMode == 'light')
        _themeMode.sink.add(ThemeModePreference.light);
      if (savedThemeMode == 'system')
        _themeMode.sink.add(ThemeModePreference.system);
    }
    if (savedPrimaryColor != null) {
      _primaryColor.sink.add(
        themeColors.firstWhere(
          (color) => color.toString() == savedPrimaryColor,
        ),
      );
    }
  }

  Future<void> setThemeMode(ThemeModePreference preference) async {
    _themeMode.sink.add(preference);
    await prefsInstance.setString(_themeModeKey, preference.name);
  }

  Future<void> setPrimaryColor(Color color) async {
    _primaryColor.sink.add(color);
    await prefsInstance.setString(_primaryColorKey, color.toString());
  }

  void dispose() {
    _themeMode.close();
    _primaryColor.close();
  }
}

final preferencesBloc = PreferencesBloc();
