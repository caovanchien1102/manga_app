class Chapter {
  String? url;
  String? name;
  String? timeUpdate;

  Chapter({
    this.url,
    this.name,
    this.timeUpdate,
  });

  @override
  String toString() {
    return "Url: $url <=> Name: $name";
  }
}
