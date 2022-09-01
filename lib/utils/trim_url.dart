String? trimUrl(String? url) {
  if (url == null) {
    return null;
  }

  return url.trimLeft().splitMapJoin(
    RegExp("//"),
    onMatch: (match) {
      if (match.start == 0) {
        return "https://";
      }
      return url.substring(match.start, match.end);
    },
  );
}
