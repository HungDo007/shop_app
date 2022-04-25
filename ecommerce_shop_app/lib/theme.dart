import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: appBarTheme(),
    textTheme: textTheme(),
    // inputDecorationTheme: inputDecorationTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primarySwatch: Colors.orange,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(
          Colors.white,
        ),
      ),
    ),
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    foregroundColor: Colors.black,
    color: Colors.white,
    elevation: 0,
    // iconTheme: const IconThemeData(color: Colors.black),
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    // toolbarTextStyle: const TextTheme(
    //   headline6: TextStyle(color: Color(0XFF8B8B8B), fontSize: 18),
    // ).bodyText2,
    titleTextStyle: const TextTheme(
      headline6: TextStyle(color: Color(0XFF8B8B8B), fontSize: 18),
    ).headline6,
  );
}

TextTheme textTheme() {
  return TextTheme(
    bodyText1: TextStyle(color: Colors.white),
    // bodyText2: TextStyle(color: kTextColor),
  );
}
