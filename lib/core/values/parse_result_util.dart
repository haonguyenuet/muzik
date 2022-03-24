class ParseResult {
  late List collection;
  late Map index;

  ParseResult() {
    collection = [];
    index = {};
  }

  add(dynamic item, dynamic identifier) {
    collection.add(item);
    index[identifier] = item;
  }
}
