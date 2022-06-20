import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_project/controllers/CartController.dart';
import 'package:test_project/controllers/HomeController.dart';
import 'package:test_project/views/CartPage.dart';
import 'package:test_project/views/ItemPage.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartController cartCntrl = Get.find();

    return Scaffold(
      backgroundColor: Colors.teal,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CartPage()));
        },
        icon: Icon(Icons.shopping_cart),
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black,
        label: GetBuilder<CartController>(builder: (controller) {
          return Text(
            controller.cartProducts.length.toString(),
            style: TextStyle(fontSize: 20),
          );
        }),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: GetBuilder<CartController>(builder: (cc) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Product Count: ${cc.cartProducts.length}',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Text(
                        'Total Units: ${cc.totalUnits()}',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Total Price: ${cc.totalPrice()}',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              );
            }),
          ),
          Expanded(child: GetBuilder<HomeController>(builder: (controller) {
            var prods = controller.products;

            return ListView.builder(
                itemCount: controller.products.length + 1,
                itemBuilder: (context, index) {
                  if (index == controller.products.length) {
                    return SizedBox(height: 100);
                  }
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ItemPage(
                                    pointer: index,
                                  )));
                    },
                    child: Card(
                      margin: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    prods[index].name,
                                    style: TextStyle(fontSize: 24),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Unit Price: ${prods[index].unitPrice}',
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Special Price: ${prods[index].spPrice}',
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                controller.increment(index);
                                cartCntrl.addToCart(controller.products[index]);
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.black,
                                foregroundColor: Colors.white,
                                radius: 16.0,
                                child: Icon(Icons.add),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              '${prods[index].quantity}',
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                controller.decrement(index);
                                if (controller.products[index].quantity != 0) {
                                  cartCntrl
                                      .addToCart(controller.products[index]);
                                } else if (controller
                                        .products[index].quantity ==
                                    0) {
                                  cartCntrl.removeFromCart(
                                      controller.products[index]);
                                }
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.black,
                                foregroundColor: Colors.white,
                                radius: 16.0,
                                child: Icon(Icons.remove),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }))
        ],
      )),
    );
  }
}
