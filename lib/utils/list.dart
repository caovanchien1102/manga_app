extension ListExtension<T> on List<T> {
  T? getOrNull(int index) {
    try {
      return this[index];
    } catch (e) {
      return null;
    }
  }
}
