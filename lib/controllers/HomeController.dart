import 'package:get/get.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:test_project/models/Product.dart';

class HomeController extends GetxController {
  var products = <Product>[].obs;

  void increment(int index) {
    products[index].quantity++;
    update();
  }

  void decrement(int index) {
    if (products[index].quantity > 0) {
      products[index].quantity--;
      update();
    }
  }

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    var url =
        Uri.parse('https://mocki.io/v1/26ca1ca6-332a-46fe-9df8-392d87a0ecf2');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      List<Product> prodList = [];
      jsonResponse['product_list']
          .forEach((element) => prodList.add(getProdFromJson(element)));
      products.value = prodList;
      update();
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}
