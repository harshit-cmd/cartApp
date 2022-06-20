class Variant {
  final String type;
  final String value;

  Variant(this.type, this.value);
}

List<Variant>? getVariFromJson(List<dynamic> json) {
  if (json.length == 0) {
    return null;
  }
  var list = <Variant>[];
  json.forEach((element) {
    list.add(Variant(element['variant_type'], element['variant_value']));
  });
  return list;
}
