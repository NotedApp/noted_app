extension ListExtension<T> on List<T> {
  bool containsAll(Iterable<T> items) {
    final list = items.toList();
    forEach(list.remove);
    return list.isEmpty;
  }
}
