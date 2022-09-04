import 'package:html/dom.dart';
import 'package:http/http.dart';
import 'package:html/parser.dart';
import 'package:manga_app/model/category.dart';
import 'package:manga_app/model/chapter.dart';
import 'package:manga_app/model/content.dart';
import 'package:manga_app/model/manga.dart';
import 'package:manga_app/page/content/bloc/content_state.dart';
import 'package:manga_app/page/detail/bloc/detail_state.dart';
import 'package:manga_app/page/home/bloc/home_state.dart';
import 'package:manga_app/utils/list.dart';
import 'package:manga_app/utils/map.dart';
import 'package:manga_app/utils/trim_url.dart';

abstract class NetTruyenRepoSource {
  Future<String?> fetchBody({required String path});
}

class NetTruyenRepo extends NetTruyenRepoSource {
  String baseUrl = "http://www.nettruyenme.com";

  @override
  Future<String?> fetchBody({
    required String path,
  }) async {
    path = path.replaceFirst(RegExp(baseUrl), "");
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

  Future<DetailState> fetchDetailPage(String path) async {
    var body = await fetchBody(path: path);

    if (body != null) {
      return SuccessDetailState(
        manga: await parseDetailManga(body),
      );
    } else {
      return FailedDetailState();
    }
  }

  Future<ContentState> fetchContentPage(String path) async {
    var body = await fetchBody(path: path);

    if (body != null) {
      return SuccessContentState(
        content: await parseContentManga(body),
      );
    } else {
      return FailedContentState();
    }
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

    var queries = {
      "base": ".row .Module-163 .ModuleContent .items .row .item",
      "url": "a",
      "thumb": "a img",
      "name": "figcaption h3 a",
      "description": ".box_tootip .box_text",
      "categories": ".box_tootip .message_main p",
      "chapters": "figcaption .comic-item li.chapter",
    };

    var elements = documentQuery<List<Element>>(
      document: parse(body),
      query: queries.getOrNull("base"),
      isAll: true,
    );

    elements?.forEach((element) {
      var urlElement = documentQuery<Element>(
        element: element,
        query: queries.getOrNull("url"),
      );
      var thumbElement = documentQuery<Element>(
        element: element,
        query: queries.getOrNull("thumb"),
      );
      var nameElement = documentQuery<Element>(
        element: element,
        query: queries.getOrNull("name"),
      );
      var descriptionElement = documentQuery<Element>(
        element: element,
        query: queries.getOrNull("description"),
      );
      var categoriesElement = documentQuery<List<Element>>(
        element: element,
        query: queries.getOrNull("categories"),
        isAll: true,
      );
      var chaptersElements = documentQuery<List<Element>>(
        element: element,
        query: queries.getOrNull("chapters"),
        isAll: true,
      );

      var categories = <String>[];
      var timeUpdate = "";
      for (var element in categoriesElement ?? <Element>[]) {
        if (element.text.contains("Thể loại:")) {
          for (var category in element.text.split(RegExp(", "))) {
            categories.add(
              category.replaceAll(RegExp("Thể loại:|\n"), "").trim(),
            );
          }
        } else if (element.text.contains("Ngày cập nhật:")) {
          timeUpdate =
              element.text.replaceAll(RegExp("Ngày cập nhật:|\n"), "").trim();
        }
      }

      var chapters = <Chapter>[];
      for (var element in chaptersElements ?? <Element>[]) {
        var chapterElement = element.querySelector("a");
        chapters.add(
          Chapter(
            url: chapterElement?.attributes["href"]?.trim(),
            name: chapterElement?.text.trim(),
          ),
        );
      }

      mangas.add(Manga(
        url: trimUrl(urlElement?.attributes["href"]),
        thumb: trimUrl(thumbElement?.attributes["data-original"]),
        name: nameElement?.text,
        timeUpdate: timeUpdate == "" ? null : timeUpdate,
        description: descriptionElement?.text,
        categories: categories,
        chapters: chapters,
      ));
    });

    return mangas;
  }

  Future<Manga?> parseDetailManga(String? body) async {
    var listQuery = {
      "name": "#item-detail .title-detail",
      "timeUpdate": "#item-detail time.small",
      "thumb": "#item-detail .detail-info .col-image img",
      "description": "#item-detail .detail-content p",
      "categories": "#item-detail .detail-info .list-info .kind a",
      "author": "#item-detail .detail-info .list-info .author",
      "status": "#item-detail .detail-info .list-info .status",
      "chapters": "#item-detail .list-chapter nav ul li.row",
    };

    var document = parse(body);

    var thumbElement = documentQuery<Element>(
      document: document,
      query: listQuery.getOrNull("thumb"),
    );
    var nameElement = documentQuery<Element>(
      document: document,
      query: listQuery.getOrNull("name"),
    );
    var descriptionElement = documentQuery<Element>(
      document: document,
      query: listQuery.getOrNull("description"),
    );
    var timeUpdateElement = documentQuery<Element>(
      document: document,
      query: listQuery.getOrNull("timeUpdate"),
    );
    var authorElement = documentQuery<Element>(
      document: document,
      query: listQuery.getOrNull("author"),
    );
    var statusElement = documentQuery<Element>(
      document: document,
      query: listQuery.getOrNull("status"),
    );
    var categoriesElements = documentQuery<List<Element>>(
      document: document,
      query: listQuery.getOrNull("categories"),
      isAll: true,
    );
    var chaptersElements = documentQuery<List<Element>>(
      document: document,
      query: listQuery.getOrNull("chapters"),
      isAll: true,
    );

    var categories = <String>[];
    for (var element in categoriesElements ?? <Element>[]) {
      categories.add(
        element.text.trim(),
      );
    }

    var chapters = <Chapter>[];
    for (var element in chaptersElements ?? <Element>[]) {
      var chapterElement = element.querySelector(".chapter a");
      var timeUpdateElement =
          element.querySelector(".col-xs-4.text-center.no-wrap.small");
      chapters.add(
        Chapter(
          url: chapterElement?.attributes["href"]?.trim(),
          name: chapterElement?.text.trim(),
          timeUpdate: timeUpdateElement?.text.trim(),
        ),
      );
    }

    return Manga(
      thumb: trimUrl(thumbElement?.attributes["src"]),
      name: nameElement?.text.trim(),
      description: descriptionElement?.text.trim(),
      timeUpdate: timeUpdateElement?.text
          .replaceAll(RegExp(r"\[Cập nhật lúc: |\]"), "")
          .trim(),
      author: authorElement?.text.replaceAll(RegExp("Tác giả"), "").trim(),
      status: statusElement?.text.replaceAll(RegExp("Tình trạng"), "").trim(),
      categories: categories,
      chapters: chapters,
    );
  }

  Future<Content?> parseContentManga(String? body) async {
    var queries = {"page": ".reading-detail .page-chapter img"};

    var pageElements = documentQuery<List<Element>>(
      document: parse(body),
      query: queries.getOrNull("page"),
      isAll: true,
    );

    var contents = <String>[];

    pageElements?.forEach((element) {
      var url = trimUrl(element.attributes.getOrNull("data-original"));
      if (url != null) {
        contents.add(url);
      }
    });

    return Content(
      contents: contents,
      referer: baseUrl,
    );
  }

  /// === Utils === ///

  TResult? documentQuery<TResult>({
    Document? document,
    Element? element,
    String? query,
    bool isAll = false,
  }) {
    try {
      if (isAll) {
        if (element != null) {
          return element.querySelectorAll(query ?? "") as TResult?;
        } else {
          return document?.querySelectorAll(query ?? "") as TResult?;
        }
      } else {
        if (element != null) {
          return element.querySelector(query ?? "") as TResult?;
        } else {
          return document?.querySelector(query ?? "") as TResult?;
        }
      }
    } catch (e) {
      return null;
    }
  }
}
