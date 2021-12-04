import 'package:flutter/material.dart';
import 'package:wapp_chat/app/core/theme/color_theme.dart';
final ThemeData appTheme = ThemeData(
  primaryColor: primaryDark,
  fontFamily: 'Quicksand',
  appBarTheme: const AppBarTheme(
    backgroundColor: primaryDark,
    toolbarTextStyle: TextStyle(
      color: primaryDark
    ),
  ),
  tabBarTheme: const TabBarTheme(
    unselectedLabelColor: primaryLight,
    labelColor: light,
  ),
);