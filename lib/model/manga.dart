import 'package:manga_app/model/chapter.dart';

class Manga {
  String? url;
  String? thumb;
  String? name;
  String? author;
  String? status;
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
    this.author,
    this.status,
  });

  @override
  String toString() {
    return 'Manga{url: $url, thumb: $thumb, name: $name, author: $author, status: $status, description: $description, newChapter: $newChapter, timeUpdate: $timeUpdate, referer: $referer, categories: $categories, chapters: $chapters}';
  }
}
