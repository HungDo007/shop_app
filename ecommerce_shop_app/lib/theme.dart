import 'package:flutter/material.dart';

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
  return const AppBarTheme(
    backgroundColor: Colors.orange,
    foregroundColor: Colors.white,
    elevation: 0,
    // systemOverlayStyle: SystemUiOverlayStyle.light,
    // toolbarTextStyle: const TextTheme(
    //   headline6: TextStyle(color: Color(0XFF8B8B8B), fontSize: 18),
    // ).bodyText2,
    // titleTextStyle: const TextTheme(
    //   headline6: TextStyle(fontSize: 18),
    // ).headline6,
  );
}

TextTheme textTheme() {
  return const TextTheme(
    bodyText1: TextStyle(
      fontSize: 16,
    ),
    bodyText2: TextStyle(
      fontSize: 18,
    ),
    // headline5: TextStyle(color: Colors.red),
  );
}
