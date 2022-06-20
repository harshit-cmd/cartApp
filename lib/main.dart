import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:test_project/controllers/CartController.dart';
import 'controllers/HomeController.dart';
import 'views/MyHomePage.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('shopping_cart');
  Get.put(HomeController());
  Get.put(CartController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}
