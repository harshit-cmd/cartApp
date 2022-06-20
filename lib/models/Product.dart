import 'package:test_project/models/Variants.dart';

class Product {
  final String name;
  final int unitPrice;
  final int id;
  int quantity;
  int spPrice;
  final List<Variant>? variants;
  Variant? chosenColor;
  Variant? chosenSize;

  Product(this.name, this.quantity, this.spPrice, this.unitPrice, this.variants,
      this.id) {
    if (variants != null) {
      List c = [];
      List s = [];
      variants!.forEach((element) {
        if (element.type == 'color')
          c.add(element);
        else if (element.type == 'size') s.add(element);
      });
      chosenColor = c.first;
      chosenSize = s.first;
    }
  }
}

Product getProdFromJson(Map<String, dynamic> json) {
  return Product(json['name'], 0, json['sp'], int.parse(json['unitprice']),
      getVariFromJson(json['product_variants']), json['id']);
}

Map<String, dynamic> getMapFromProd(Product p) {
  if (p.chosenColor == null)
    return {
      'name': p.name,
      'unitPrice': p.unitPrice,
      'quantity': p.quantity,
      'spPrice': p.spPrice,
      'id': p.id
    };
  else
    return {
      'name': p.name,
      'unitPrice': p.unitPrice,
      'quantity': p.quantity,
      'spPrice': p.spPrice,
      'id': p.id,
      'chosenColor': p.chosenColor!.value,
      'chosenSize': p.chosenSize!.value,
    };
}

Product getProdFromMap(Map<String, dynamic> m) {
  if (m['chosenColor'] != null) {
    Product p = Product(
        m['name'], m['quantity'], m['spPrice'], m['unitPrice'], null, m['id']);
    p.chosenColor = Variant('color', m['chosenColor']);
    p.chosenSize = Variant('size', m['chosenSize']);
    return p;
  } else
    return Product(
        m['name'], m['quantity'], m['spPrice'], m['unitPrice'], null, m['id']);
}
