import 'package:http/http.dart';
import 'package:html/parser.dart';
import 'package:manga_app/model/category.dart';
import 'package:manga_app/model/manga.dart';
import 'package:manga_app/page/home/bloc/home_state.dart';
import 'package:manga_app/utils/list.dart';
import 'package:manga_app/utils/trim_url.dart';

abstract class NetTruyenRepoSource {
  Future<String?> fetchBody({required String path});
}

void main() {
  var nettruyenRepo = NetTruyenRepo();

  nettruyenRepo.fetchBody(path: "").then((value) async {
    var mangas = await nettruyenRepo.parseMangaNewUpdate(value);
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

  /// === Fetch Page === ///

  Stream<HomeState> fetchHomePage() async* {
    var body = await fetchBody(path: "");

    yield CategoryHomeState(
      categories: await parseCategories(body),
    );
    yield NominationHomeState(
      mangas: await parseMangaNominations(body),
    );
    yield NewMangaUpdateHomeState(
      mangas: await parseMangaNewUpdate(body),
    );
  }

  /// === Parser Data === ///

  Future<List<Category>> parseCategories(String? body) async {
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

  Future<List<Manga>> parseMangaNominations(String? body) async {
    var mangas = <Manga>[];
    var elements = parse(body).querySelectorAll(
      ".container .ModuleContent .items-slide .item",
    );

    for (var element in elements) {
      var url = element.querySelector("a")?.attributes["href"];
      var thumb = element.querySelector("a img")?.attributes["data-src"];
      var name = element.querySelector("a img")?.attributes["alt"];
      var newChapter =
          element.querySelectorAll(".slide-caption a").getOrNull(1)?.text;
      var timeUpdate =
          element.querySelector(".slide-caption .time")?.text.trim();

      mangas.add(
        Manga(
          url: trimUrl(url),
          thumb: trimUrl(thumb),
          name: name,
          newChapter: newChapter,
          timeUpdate: timeUpdate,
        ),
      );
    }

    return mangas;
  }

  Future<List<Manga>> parseMangaNewUpdate(String? body) async {
    var mangas = <Manga>[];
    var elements = parse(body).querySelectorAll(
      ".row .Module-163 .ModuleContent .items .row .item",
    );

    for (var element in elements) {
      var url = element.querySelector("a")?.attributes["href"];
      var thumb = element.querySelector("a img")?.attributes["data-original"];
      var name = element.querySelector("figcaption h3 a")?.text;
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

      mangas.add(
        Manga(
          url: trimUrl(url),
          thumb: trimUrl(thumb),
          name: name,
          description: description,
          categories: categories,
        ),
      );
    }

    return mangas;
  }
}
