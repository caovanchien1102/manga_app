class Manga {
  String? url;
  String? thumb;
  String? name;
  String? description;

  String? newChapter;
  String? timeUpdate;

  List<String>? categories;
  List<String>? chapters;

  Manga({
    this.url,
    this.thumb,
    this.name,
    this.description,
    this.newChapter,
    this.timeUpdate,
    this.categories,
    this.chapters,
  });

  @override
  String toString() {
    return "${categories?.length} $categories";
  }
}
