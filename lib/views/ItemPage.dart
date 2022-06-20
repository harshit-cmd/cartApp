import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_project/controllers/CartController.dart';
import 'package:test_project/controllers/HomeController.dart';
import 'package:test_project/models/Product.dart';
import 'package:test_project/views/RadioButton.dart';

class ItemPage extends StatelessWidget {
  final String? chosenVals;
  int pointer;
  ItemPage({Key? key, required this.pointer, this.chosenVals})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find();
    final HomeController homeController = Get.find();
    if (chosenVals != null) {
      var id = cartController.cartProducts[pointer].id;
      for (int i = 0; i < homeController.products.length; i++) {
        if (homeController.products[i].id == id) {
          pointer = i;
        }
      }
    }

    return Scaffold(
      backgroundColor: Colors.teal,
      body: SafeArea(
        child: Center(
          child: GetBuilder<HomeController>(builder: (controller) {
            return Padding(
              padding: EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 64,
                        ),
                        Text(
                          controller.products[this.pointer].name,
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Unit Price: ${controller.products[this.pointer].unitPrice}',
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Special Price: ${controller.products[this.pointer].spPrice}',
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () => controller.increment(pointer),
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
                              '${controller.products[pointer].quantity}',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            GestureDetector(
                              onTap: () => controller.decrement(pointer),
                              child: CircleAvatar(
                                backgroundColor: Colors.black,
                                foregroundColor: Colors.white,
                                radius: 16.0,
                                child: Icon(Icons.remove),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        controller.products[this.pointer].variants == null
                            ? SizedBox()
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Colors: ',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  myRadioButton(
                                      initVal: chosenVals != null
                                          ? chosenVals!.split(':')[0]
                                          : null,
                                      list: colors(controller
                                          .products[this.pointer].variants),
                                      pointer: pointer),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    'Sizes: ',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  myRadioButton(
                                      initVal: chosenVals != null
                                          ? chosenVals!.split(':')[1]
                                          : null,
                                      list: sizes(controller
                                          .products[this.pointer].variants),
                                      pointer: pointer),
                                ],
                              )
                      ],
                    ),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.amber,
                      ),
                      onPressed: () async {
                        await cartController
                            .addToCart(controller.products[this.pointer]);
                        Navigator.pop(context);
                      },
                      child: Text(
                        chosenVals != null ? 'Done' : 'Add to cart',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
