import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manga_app/page/content/bloc/content_bloc.dart';
import 'package:manga_app/page/content/content_page.dart';
import 'package:manga_app/page/detail/bloc/detail_bloc.dart';
import 'package:manga_app/page/detail/detail_page.dart';
import 'package:manga_app/page/home/bloc/home_bloc.dart';
import 'package:manga_app/page/home/home_page.dart';

Route genRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomePage.route:
      return settings.buildRoute(builder: (context) {
        return BlocProvider(
          create: (context) => HomeBloc(),
          child: const HomePage(),
        );
      });
    case DetailPage.route:
      var path = settings.arguments as String?;
      return settings.buildRoute(builder: (context) {
        return BlocProvider(
          create: (context) => DetailBloc(),
          child: DetailPage(
            path: path,
          ),
        );
      });
    case ContentPage.route:
      var path = settings.arguments as String?;
      return settings.buildRoute(builder: (context) {
        return BlocProvider(
          create: (context) => ContentBloc(),
          child: ContentPage(
            path: path,
          ),
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
