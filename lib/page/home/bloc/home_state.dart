import 'package:manga_app/model/category.dart';
import 'package:manga_app/model/manga.dart';

class HomeState {}

class LoadingHomeState extends HomeState {}

class CategoryHomeState extends HomeState {
  List<Category>? categories;

  CategoryHomeState({this.categories});
}

class NewMangaUpdateHomeState extends HomeState {
  List<Manga>? mangas;

  NewMangaUpdateHomeState({this.mangas});
}

class NominationHomeState extends HomeState {
  List<Manga>? mangas;

  NominationHomeState({this.mangas});
}
