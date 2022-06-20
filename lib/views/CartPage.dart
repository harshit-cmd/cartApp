import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_project/controllers/CartController.dart';
import 'package:test_project/views/ItemPage.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          foregroundColor: Colors.black,
          backgroundColor: Colors.amber,
          onPressed: () {
            Navigator.pop(context);
          }),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 16,
            ),
            Expanded(
              child: GetBuilder<CartController>(builder: (controller) {
                return ListView.builder(
                    itemCount: controller.cartProducts.length + 1,
                    itemBuilder: (context, index) {
                      if (index == controller.cartProducts.length) {
                        return SizedBox(height: 100);
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Card(
                          child: Container(
                            padding: EdgeInsets.all(16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      controller.cartProducts[index].name,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 22),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "Unit Price: ${controller.cartProducts[index].unitPrice}",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 22),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "Special Price: ${controller.cartProducts[index].spPrice}",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 22),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "Quantity: ${controller.cartProducts[index].quantity}",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 22),
                                    ),
                                    controller.cartProducts[index].variants ==
                                            null
                                        ? SizedBox()
                                        : Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                  'Chosen Color: ${controller.cartProducts[index].chosenColor!.value}',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 22)),
                                              Text(
                                                  'Chosen Size: ${controller.cartProducts[index].chosenSize!.value}',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 22))
                                            ],
                                          )
                                  ],
                                ),
                                Expanded(child: SizedBox()),
                                GestureDetector(
                                  onTap: () {
                                    controller.removeFromCart(
                                        controller.cartProducts[index]);
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ItemPage(
                                                  pointer: index,
                                                  chosenVals: controller
                                                              .cartProducts[
                                                                  index]
                                                              .chosenColor !=
                                                          null
                                                      ? '${controller.cartProducts[index].chosenColor!.value}:${controller.cartProducts[index].chosenSize!.value}'
                                                      : null,
                                                )));
                                  },
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              }),
            ),
          ],
        ),
      ),
    );
  }
}
