import 'package:flutter/material.dart';
import 'package:manga_app/theme/color_scheme.dart';

class ThemeManga {
  static final lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: lightColorScheme,
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: darkColorScheme,
  );
}
