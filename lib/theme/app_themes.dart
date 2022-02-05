import 'package:dentistry/resources/colors_res.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    visualDensity: const VisualDensity(vertical: 0.5, horizontal: 0.5),
    textTheme: TextTheme(
      headline6: TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w500
      ),
      subtitle1: TextStyle(
          color: Colors.grey,
          fontSize: 12
      ),
    ),
    primarySwatch: const MaterialColor(
      0xFF6f94fe,
      <int, Color>{
        50: Color(0x1a6f94fe),
        100: Color(0xa16f94fe),
        200: Color(0xaa6f94fe),
        300: Color(0xaf6f94fe),
        400: Color(0xff6f94fe),
        500: Color(0xffEDD5B3),
        600: Color(0xffDEC29B),
        700: Color(0xffC9A87C),
        800: Color(0xffB28E5E),
        900: Color(0xff936F3E)
      },
    ),
    iconTheme: IconThemeData(
      color: ColorsRes.fromHex(ColorsRes.primaryColor)
    ),
    indicatorColor: ColorsRes.fromHex(ColorsRes.primaryColor),
    progressIndicatorTheme: ProgressIndicatorThemeData(
        color: ColorsRes.fromHex(ColorsRes.primaryColor)),
    tabBarTheme: TabBarTheme(
        labelColor: ColorsRes.fromHex(ColorsRes.eerieBlackColor),
        labelStyle:
            TextStyle(color: ColorsRes.fromHex(ColorsRes.whiteColor))),
    primaryColor: ColorsRes.fromHex(ColorsRes.primaryColor),
    primaryColorBrightness: Brightness.light,
    primaryColorLight: Color(0x1a6f94fe),
    primaryColorDark: Color(0xff936F3E),
    canvasColor: ColorsRes.fromHex(ColorsRes.primaryColor),
    appBarTheme: AppBarTheme(
      color: Colors.white,
    ),
    accentColor: Color(0xff457BE0),
    accentColorBrightness: Brightness.light,
    scaffoldBackgroundColor: ColorsRes.fromHex(ColorsRes.whiteColor),
    bottomAppBarColor: ColorsRes.fromHex(ColorsRes.whiteColor),
    cardColor: ColorsRes.fromHex(ColorsRes.whiteColor),
    dividerColor: Color(0x1f6D42CE),
    focusColor: Color(0x1a6f94fe));

ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    visualDensity: VisualDensity(vertical: 0.5, horizontal: 0.5),
    textTheme: TextTheme(
      headline6: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500
      ),
      subtitle1: TextStyle(
          color: Colors.grey,
          fontSize: 12
      ),
    ),
    primarySwatch: const MaterialColor(
      0xFF6f94fe,
      <int, Color>{
        50: Color(0x1a5D4524),
        100: Color(0xa15D4524),
        200: Color(0xaa5D4524),
        300: Color(0xaf5D4524),
        400: Color(0x1a483112),
        500: Color(0xa1483112),
        600: Color(0xaa483112),
        700: Color(0xff483112),
        800: Color(0xaf2F1E06),
        900: Color(0xff2F1E06)
      },
    ),
    iconTheme: IconThemeData(
        color: ColorsRes.fromHex(ColorsRes.whiteColor)
    ),
    indicatorColor: ColorsRes.fromHex(ColorsRes.primaryColor),
    tabBarTheme: TabBarTheme(
        labelColor: ColorsRes.fromHex(ColorsRes.whiteColor),
        labelStyle:
            TextStyle(color: ColorsRes.fromHex(ColorsRes.eerieBlackColor))),
    progressIndicatorTheme: ProgressIndicatorThemeData(
        color: ColorsRes.fromHex(ColorsRes.whiteColor)),
    primaryColor: Color(0xff5D4524),
    primaryColorBrightness: Brightness.dark,
    primaryColorLight: Color(0x1a311F06),
    primaryColorDark: Color(0xff936F3E),
    canvasColor: ColorsRes.fromHex(ColorsRes.codBlackColor),
    appBarTheme: AppBarTheme(
      color: ColorsRes.fromHex(ColorsRes.eerieBlackColor),
    ),
    accentColor: Color(0x383535FF),
    accentColorBrightness: Brightness.dark,
    scaffoldBackgroundColor: ColorsRes.fromHex(ColorsRes.codBlackColor),
    bottomAppBarColor: ColorsRes.fromHex(ColorsRes.eerieBlackColor),
    cardColor: ColorsRes.fromHex(ColorsRes.eerieBlackColor),
    dividerColor: Color(0x1f6D42CE),
    focusColor: Color(0x1a311F06));
