import 'package:flutter/material.dart';
import 'package:patta/app/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

class AppThemes {

  static const SETTINGS_KEY = "APP_THEME";

  static final version1ColorScheme = ColorScheme(
    brightness: Brightness.light,
    inversePrimary: const Color(0xffBA5626),
    inverseSurface: const Color(0xffd6d6d6),
    primary: const Color(0xffdcd3c0),
    onPrimary: const Color(0xff000000),
    secondary: const Color(0xffdcd3c0),
    onSecondary: const Color(0xff6d695f),
    onTertiary: const Color(0xff207868),
    surface: const Color(0xffffffff),
    onSurface: const Color(0xff000000),
    onSurfaceVariant: const Color(0xff3171cc),
    surface: const Color(0xfff4efe7),
    onSurface: const Color(0xff6d695f),
    error: const Color(0xffBA5626),
    onError: const Color(0xfff4efe7),
  );

  static final version1 = ThemeData(colorScheme: version1ColorScheme);

  static final version1SettingsThemeData = SettingsThemeData(
    trailingTextColor: version1ColorScheme.onSurface,
    settingsSectionBackground: version1ColorScheme.surface,
    settingsListBackground: version1ColorScheme.surface,
    dividerColor: version1ColorScheme.surface,
    tileHighlightColor: version1ColorScheme.inverseSurface,
    titleTextColor: version1ColorScheme.onSurface,
    leadingIconsColor: version1ColorScheme.onSecondary,
    tileDescriptionTextColor: version1ColorScheme.onSurface,
    settingsTileTextColor: version1ColorScheme.onPrimary,
    inactiveTitleColor: version1ColorScheme.inverseSurface,
    inactiveSubtitleColor: version1ColorScheme.inverseSurface
  );

  static final darkColorScheme = ColorScheme(
      brightness: Brightness.dark,
      inversePrimary: const Color(0xffBA5626),
      inverseSurface: const Color(0xff8f7140),
      primary: const Color(0xff8f7140),
      onPrimary: const Color(0xffeae9e7),
      secondary: const Color(0xff8f7140),
      onSecondary: const Color(0xffc1b196),
      onTertiary: const Color(0xff1a6053),
      surface: const Color(0xff524025),
      onSurface: const Color(0xffcbc7be),
      onSurfaceVariant: const Color(0xffffc72c),
      surface: const Color(0xff292112),
      onSurface: const Color(0xff908573),
      error: const Color(0xffBA5626),
      onError: const Color(0xfff4efe7)
  );

  static final dark = ThemeData(colorScheme: darkColorScheme);

  static final darkSettingsThemeData = SettingsThemeData(
      trailingTextColor: darkColorScheme.onSurface,
      settingsSectionBackground: darkColorScheme.surface,
      settingsListBackground: darkColorScheme.surface,
      dividerColor: darkColorScheme.surface,
      tileHighlightColor: darkColorScheme.inverseSurface,
      titleTextColor: darkColorScheme.onSurface,
      leadingIconsColor: darkColorScheme.onSecondary,
      tileDescriptionTextColor: darkColorScheme.onSurface,
      settingsTileTextColor: darkColorScheme.onPrimary,
      inactiveTitleColor: darkColorScheme.inverseSurface,
      inactiveSubtitleColor: darkColorScheme.inverseSurface,
  );

  static Image quoteBackground(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    return themeProvider.isLight(context)
        ? Image.asset("assets/images/quote-bg-light-transparent-700x1400.png", fit: BoxFit.fitWidth)
        : Image.asset("assets/images/quote-bg-dark-brown-transparent-700x1400.png", fit: BoxFit.fitWidth);
  }

  static Color contextFreeDefault = const Color(0xff8f7140);
  static List<Color> contextFreeButtonGradient = <Color>[Color(0xff207868),Color(0xff1c7063),Color(0xff1a6053),];

  static Color overlayText(String? hex) {
    var i = int.tryParse(hex?.replaceFirst('#', '0xFF') ?? "0xFFFFFFFF");
    return Color(i ?? 0xFFFFFFFF);
  }

  static checkIcon(BuildContext context) {
    return Icon(Icons.check, color: Theme.of(context).colorScheme.inversePrimary);
  }
} 