import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:manga_app/application/manga_application.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    const MangaApplication(),
  );
}
