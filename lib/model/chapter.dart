class Chapter {
  String? url;
  String? name;

  Chapter({
    this.url,
    this.name,
  });

  @override
  String toString() {
    return "Url: $url <=> Name: $name";
  }
}
