import 'package:flutter/material.dart';

extension ThemeExtension on BuildContext? {
  ThemeData? get themeData => _themeData();

  ThemeData? _themeData() {
    var context = this;
    if (context != null) {
      return Theme.of(context);
    } else {
      return null;
    }
  }
}
