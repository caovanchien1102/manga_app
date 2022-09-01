import 'package:manga_app/model/chapter.dart';

class Manga {
  String? url;
  String? thumb;
  String? name;
  String? description;

  String? newChapter;
  String? timeUpdate;
  String? referer;

  List<String>? categories;
  List<Chapter>? chapters;

  Manga({
    this.url,
    this.thumb,
    this.name,
    this.description,
    this.newChapter,
    this.timeUpdate,
    this.categories,
    this.chapters,
    this.referer,
  });

  @override
  String toString() {
    return "${categories?.length} $categories";
  }
}
