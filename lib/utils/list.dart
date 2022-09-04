extension ListExtension<T> on List<T>? {
  T? getOrNull(int index) {
    try {
      return this?[index];
    } catch (e) {
      return null;
    }
  }

  T? firstOrNull() {
    try {
      return this?.first;
    } catch (e) {
      return null;
    }
  }

  T? lastOrNull() {
    try {
      return this?.last;
    } catch (e) {
      return null;
    }
  }

  List<TResult> list<TResult>({
    required TResult Function(T value) process,
  }) {
    var children = <TResult>[];
    try {
      this?.forEach((element) {
        children.add(process(element));
      });
    } catch (e) {
      return [];
    }
    return children;
  }
}
