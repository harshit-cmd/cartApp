import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../models/Product.dart';

class CartController extends GetxController {
  final myBox = Hive.box('shopping_cart');
  var cartProducts = <Product>[].obs;

  int totalUnits() {
    int i = 0;
    cartProducts.forEach((element) {
      i += element.quantity;
    });
    return i;
  }

  int totalPrice() {
    int i = 0;
    cartProducts.forEach((element) {
      i += element.quantity * element.unitPrice;
    });
    return i;
  }

  @override
  void onInit() async {
    await fetchProducts();
    super.onInit();
  }

  Future<void> fetchProducts() async {
    final List? cart = myBox.get('cart');
    if (cart != null) {
      var l = <Product>[];
      cart.forEach((element) =>
          l.add(getProdFromMap(Map<String, dynamic>.from(element))));
      cartProducts.value = l;
    }
    update();
  }

  Future<void> addToCart(Product prod) async {
    int j = -1;
    for (int i = 0; i < cartProducts.length; i++) {
      if (cartProducts[i].id == prod.id) {
        j = i;
      }
    }
    if (j != -1) cartProducts.removeAt(j);
    cartProducts.add(prod);
    List l = [];
    cartProducts.forEach((element) => l.add(getMapFromProd(element)));
    await myBox.put('cart', l);
    update();
  }

  Future<void> removeFromCart(Product prod) async {
    cartProducts.remove(prod);
    List l = [];
    cartProducts.forEach((element) => l.add(getMapFromProd(element)));
    await myBox.put('cart', l);
    update();
  }
}
