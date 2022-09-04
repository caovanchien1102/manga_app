class Pagination {}

extension _PaginationExtension on String {
  int getPage() {
    String page = '';

    splitMapJoin(
      RegExp("page=[0-9]*"),
      onMatch: (match) {
        page = substring(
          match.start,
          match.end,
        ).replaceAll(
          RegExp("page="),
          "",
        );
        return "____";
      },
    );

    try {
      return int.parse(page);
    } catch (e) {
      return -1;
    }
  }
}

void main() {
  var url = "http://www.nettruyenme.com/tim-truyen/action-95?page=2f2";

  url.splitMapJoin(RegExp("page=[0-9]*"), onMatch: (match) {
    print("Chien: ${url.getPage()}");
    return "aa";
  });
}
