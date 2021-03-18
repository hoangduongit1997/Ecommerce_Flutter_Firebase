import 'package:e_commerce_app/configs/config.dart';
import 'package:e_commerce_app/constants/color_constant.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData currentTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: "Roboto",
    appBarTheme: appBarTheme,
    textTheme: textTheme,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: COLOR_CONST.primaryColor,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static final appBarTheme = AppBarTheme(
    color: Colors.white,
    elevation: 0,
    brightness: Brightness.light,
    iconTheme: IconThemeData(color: Colors.black),
    centerTitle: true,
    textTheme: TextTheme(
      headline6: TextStyle(
        color: COLOR_CONST.textColor,
        fontSize: SizeConfig.defaultSize * 2.5,
      ),
    ),
  );

  static final textTheme = TextTheme(
      bodyText1: TextStyle(color: COLOR_CONST.textColor),
      bodyText2: TextStyle(color: COLOR_CONST.textColor));

  /// Singleton factory
  static final AppTheme _instance = AppTheme._internal();

  factory AppTheme() {
    return _instance;
  }

  AppTheme._internal();
}
