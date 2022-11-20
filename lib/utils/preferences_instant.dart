import 'package:shared_preferences/shared_preferences.dart';

late final SharedPreferences prefsInstance;

Future<void> loadSharedPreferencesInstance() async {
  prefsInstance = await SharedPreferences.getInstance();
}
