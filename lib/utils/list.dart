extension ListExtension<T> on List<T> {
  T? getOrNull(int index) {
    try {
      return this[index];
    } catch (e) {
      return null;
    }
  }

  T? firstOrNull() {
    try {
      return first;
    } catch (e) {
      return null;
    }
  }

  T? lastOrNull() {
    try {
      return last;
    } catch (e) {
      return null;
    }
  }
}
