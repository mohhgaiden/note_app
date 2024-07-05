import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:note_app/res/colors.dart';
import 'package:note_app/res/styles.dart';

class LightTheme {
  ThemeData light() {
    return ThemeData(
      primaryColor: Colours.app_main,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        brightness: Brightness.light,
        secondary: Colours.app_main,
        error: Colours.red,
      ),
      indicatorColor: Colours.app_main,
      scaffoldBackgroundColor: Colors.white,
      canvasColor: Colors.white,
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: Colours.app_main.withAlpha(70),
        selectionHandleColor: Colours.app_main,
        cursorColor: Colours.app_main,
      ),
      textTheme: const TextTheme(
        titleMedium: TextStyles.text,
        bodyMedium: TextStyles.text,
        titleSmall: TextStyles.textGray12,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyles.textDarkGray14,
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0.0,
        color: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      dividerTheme: const DividerThemeData(
        color: Colours.line,
        space: 0.6,
        thickness: 0.6
      ),
      cupertinoOverrideTheme: const CupertinoThemeData(
        brightness: Brightness.light,
      ),
      visualDensity: VisualDensity.standard,
    );
  }
}