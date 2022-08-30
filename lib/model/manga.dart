class Manga {
  String? url;
  String? thumb;
  String? name;
  String? description;

  List<String>? categories;
  List<String>? chapters;

  Manga({
    this.url,
    this.thumb,
    this.name,
    this.description,
    this.categories,
    this.chapters,
  });

  @override
  String toString() {
    return "${categories?.length} $categories";
  }
}
