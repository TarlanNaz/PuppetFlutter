import 'package:flutter/material.dart';

// Все цвета берутся из одного основного цвета (seedColor)
final lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
);

final darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blueGrey,
    brightness: Brightness.dark,
  ),
);
