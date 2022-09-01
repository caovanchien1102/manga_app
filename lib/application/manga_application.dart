import 'package:flutter/material.dart';
import 'package:manga_app/route/routes.dart';
import 'package:manga_app/theme/theme.dart';

class MangaApplication extends StatefulWidget {
  const MangaApplication({Key? key}) : super(key: key);

  @override
  State<MangaApplication> createState() => _MangaApplicationState();
}

class _MangaApplicationState extends State<MangaApplication> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeManga.lightTheme,
      onGenerateRoute: genRoute,
      initialRoute: "home_page",
    );
  }
}
