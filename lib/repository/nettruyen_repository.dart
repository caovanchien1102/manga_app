import 'package:http/http.dart';
import 'package:html/parser.dart';
import 'package:manga_app/model/category.dart';
import 'package:manga_app/model/manga.dart';

abstract class NetTruyenRepoSource {
  Future<String?> fetchBody({required String path});
}

void main() {
  var nettruyenRepo = NetTruyenRepo();

  nettruyenRepo.fetchBody(path: "").then((value) async {
    var mangas = await nettruyenRepo.fetchMangaNewUpdate(value);
    for (var manga in mangas) {
      print("Chien cao: $manga");
    }
    // var categories = await nettruyenRepo.fetchCategories(value);
    // var elements = parse(value).querySelectorAll(
    //   ".container .ModuleContent .items-slide .item",
    // );

    // for (var element in elements) {
    //   var url = element.querySelector("a")?.attributes["href"];
    //   var thumb = element.querySelector("a img")?.attributes["data-src"];
    //   var name = element.querySelector("a img")?.attributes["alt"];
    // }
  });
}

class NetTruyenRepo extends NetTruyenRepoSource {
  String baseUrl = "http://www.nettruyenme.com";

  @override
  Future<String?> fetchBody({required String path}) async {
    var url = Uri.tryParse("$baseUrl/$path");
    if (url != null) {
      return (await get(url)).body;
    }
    return null;
  }

  Future<List<Category>> fetchCategories(String? body) async {
    var categories = <Category>[];
    var elements = parse(body).querySelectorAll(
      ".dropdown .megamenu .clearfix .nav a",
    );

    for (var element in elements) {
      var attrs = element.attributes;
      categories.add(
        Category(
          url: attrs["href"],
          name: attrs["title"],
          description: attrs["data-title"],
        ),
      );
    }

    return categories;
  }

  Future<List<Manga>> fetchMangaNominations(String? body) async {
    var mangas = <Manga>[];
    var elements = parse(body).querySelectorAll(
      ".container .ModuleContent .items-slide .item",
    );

    for (var element in elements) {
      var url = element.querySelector("a")?.attributes["href"];
      var thumb = element.querySelector("a img")?.attributes["data-src"];
      var name = element.querySelector("a img")?.attributes["alt"];
      mangas.add(Manga(
        url: url,
        thumb: thumb,
        name: name,
      ));
    }

    return mangas;
  }

  Future<List<Manga>> fetchMangaNewUpdate(String? body) async {
    var mangas = <Manga>[];
    var elements = parse(body).querySelectorAll(
      ".row .Module-163 .ModuleContent .items .row .item",
    );

    for (var element in elements) {
      var url = element.querySelector("a")?.attributes["href"];
      var thumb = element.querySelector("a img")?.attributes["data-original"];
      var name = element.querySelector("a img")?.attributes["alt"];
      var description = element.querySelector(".box_tootip .box_text")?.text;
      var elementCategory = element.querySelectorAll(
        ".box_tootip .message_main p",
      );
      var categories = <String>[];
      for (var element in elementCategory) {
        if (element.text.contains("Thể loại:")) {
          categories.addAll(
            element.text.replaceFirst("Thể loại:", "").split(RegExp(", ")),
          );
        }
      }

      mangas.add(Manga(
        url: url,
        thumb: thumb,
        name: name,
        description: description,
        categories: categories,
      ));
    }

    return mangas;
  }
}
