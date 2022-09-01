import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manga_app/page/home/bloc/home_bloc.dart';
import 'package:manga_app/page/home/home_page.dart';

Route genRoute(RouteSettings settings) {
  switch (settings.name) {
    case "home_page":
      return settings.buildRoute(builder: (context) {
        return BlocProvider(
          create: (context) => HomeBloc(),
          child: const HomePage(),
        );
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
