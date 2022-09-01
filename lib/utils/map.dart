extension MapExtension<K, V> on Map<K, V>? {
  V? getOrNull(K? key) {
    try {
      if (key != null) {
        return this?[key];
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
