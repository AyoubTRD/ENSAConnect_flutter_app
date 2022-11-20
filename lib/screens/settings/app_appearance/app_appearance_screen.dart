import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:ensa/blocs/preferences_bloc.dart';
import 'package:ensa/utils/constants.dart';
import 'package:ensa/utils/theme.dart';
import 'package:ensa/widgets/core/app_bar_widget.dart';
import 'package:ensa/widgets/settings/settings_item_widget.dart';
import 'package:ensa/widgets/settings/settings_section_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:ionicons/ionicons.dart';

class AppAppearanceScreen extends StatefulWidget {
  const AppAppearanceScreen({Key? key}) : super(key: key);

  static const routeName = '/settings/app-appearance';

  @override
  State<AppAppearanceScreen> createState() => _AppAppearanceScreenState();
}

class _AppAppearanceScreenState extends State<AppAppearanceScreen> {
  ThemeModePreference getSystemPreference() {
    return SchedulerBinding.instance.window.platformBrightness ==
            Brightness.dark
        ? ThemeModePreference.dark
        : ThemeModePreference.light;
  }

  void updateTheme() {
    bool isDark = false;
    if ((preferencesBloc.themeMode.value == ThemeModePreference.system
            ? getSystemPreference()
            : preferencesBloc.themeMode.value) ==
        ThemeModePreference.dark) {
      isDark = true;
    }

    if (isDark) {
      DynamicTheme.of(context)
          ?.setTheme(getDarkThemeKey(preferencesBloc.primaryColor.value));
    } else {
      DynamicTheme.of(context)
          ?.setTheme(getLightThemeKey(preferencesBloc.primaryColor.value));
    }
  }

  List<Widget> renderColors(
      BuildContext context, List<Color> colors, Color selectedColor) {
    return colors.map((color) {
      return Container(
        height: 34.0,
        width: 34.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          border: selectedColor == color
              ? Border.all(
                  color: color,
                  width: 2.0,
                  style: BorderStyle.solid,
                )
              : null,
        ),
        child: Center(
          child: InkWell(
            onTap: () {
              preferencesBloc.setPrimaryColor(color);
              updateTheme();
            },
            child: Container(
              height: 24.0,
              width: 24.0,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(50.0),
              ),
            ),
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        centerTitle: true,
        showBackButton: true,
        title: Text(
          'App Appearance',
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(kDefaultPadding),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            StreamBuilder<ThemeModePreference>(
                stream: preferencesBloc.themeMode,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return Container();

                  final preference = snapshot.data!;
                  return SettingsSection(
                    title: 'THEME MODE',
                    children: [
                      Opacity(
                        opacity: preference == ThemeModePreference.system
                            ? 0.5
                            : 1.0,
                        child: SettingsItem(
                          icon: Ionicons.moon_outline,
                          title: 'Use Dark Mode',
                          suffix: SizedBox(
                            height: 20.0,
                            child: Switch(
                              value: (preference == ThemeModePreference.system
                                      ? getSystemPreference()
                                      : preference) ==
                                  ThemeModePreference.dark,
                              onChanged:
                                  preference == ThemeModePreference.system
                                      ? null
                                      : (bool dark) {
                                          preferencesBloc.setThemeMode(
                                            dark
                                                ? ThemeModePreference.dark
                                                : ThemeModePreference.light,
                                          );
                                          updateTheme();
                                        },
                            ),
                          ),
                        ),
                      ),
                      SettingsItem(
                        icon: Ionicons.cog_outline,
                        title: 'Use System Mode',
                        suffix: SizedBox(
                          height: 20.0,
                          child: Switch(
                            value: preference == ThemeModePreference.system,
                            onChanged: (useDevicePref) {
                              if (useDevicePref) {
                                preferencesBloc
                                    .setThemeMode(ThemeModePreference.system);
                              } else {
                                preferencesBloc
                                    .setThemeMode(getSystemPreference());
                              }
                              updateTheme();
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                }),
            SizedBox(
              height: kDefaultPadding,
            ),
            StreamBuilder<Color>(
                stream: preferencesBloc.primaryColor,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return Container();
                  final selectedColor = snapshot.data!;
                  return SettingsSection(title: 'THEME COLOR', children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 6.0,
                        horizontal: 12.0,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: renderColors(
                              context,
                              themeColors.skip(0).take(7).toList(),
                              selectedColor,
                            ),
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: renderColors(
                              context,
                              themeColors.skip(7).take(7).toList(),
                              selectedColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]);
                }),
          ],
        ),
      ),
    );
  }
}
