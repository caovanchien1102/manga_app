import 'package:flutter/material.dart';
import 'package:manga_app/page/home_page.dart';

Route genRoute(RouteSettings settings) {
  switch (settings.name) {
    case "home_page":
      return settings.buildRoute(builder: (context) {
        return const HomePage();
      });
    default:
      return settings.buildRoute(builder: (context) {
        return Container();
      });
  }
}

extension RouteSettingsExtension on RouteSettings? {
  buildRoute({
    required WidgetBuilder builder,
  }) {
    return MaterialPageRoute(
      builder: builder,
      settings: this,
    );
  }
}
