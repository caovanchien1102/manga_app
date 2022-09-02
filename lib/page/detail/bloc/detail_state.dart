import 'package:manga_app/model/manga.dart';

class DetailState {}

class LoadingDetailState extends DetailState {}

class SuccessDetailState extends DetailState {
  Manga? manga;

  SuccessDetailState({
    this.manga,
  });
}

class FailedDetailState extends DetailState {}
