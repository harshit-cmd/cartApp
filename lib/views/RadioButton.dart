import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_project/controllers/HomeController.dart';
import 'package:test_project/models/Variants.dart';

class myRadioButton extends StatefulWidget {
  final String? initVal;
  final int pointer;
  final List<String> list;
  const myRadioButton(
      {Key? key, required this.list, required this.pointer, this.initVal})
      : super(key: key);

  @override
  State<myRadioButton> createState() =>
      _myRadioButtonState(this.list, this.pointer, this.initVal);
}

class _myRadioButtonState extends State<myRadioButton> {
  final String? initVal;
  final int pointer;
  final List<String> list;
  _myRadioButtonState(this.list, this.pointer, this.initVal);
  String? groupValue;

  @override
  void initState() {
    if (this.initVal != null)
      groupValue = initVal;
    else
      groupValue = list.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List<Widget>.generate(
        widget.list.length,
        (int i) => Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Radio<String>(
              activeColor: Colors.white,
              value: widget.list[i],
              groupValue: groupValue,
              onChanged: handleRadioValueChange,
            ),
            Text(widget.list[i],
                style: TextStyle(fontSize: 20, color: Colors.white))
          ],
        ),
      ),
    );
  }

  void handleRadioValueChange(String? value) {
    final HomeController controller = Get.find();
    controller.products[pointer].variants!.forEach((element) {
      if (element.value == value) {
        if (element.type == 'color') {
          controller.products[pointer].chosenColor = element;
        } else {
          controller.products[pointer].chosenSize = element;
        }
      }
    });
    setState(() {
      groupValue = value;
    });
  }
}

List<String> colors(List<Variant>? a) {
  List<String> meh = [];
  a!.forEach((element) {
    if (element.type == 'color') {
      meh.add(element.value);
    }
  });
  return meh;
}

List<String> sizes(List<Variant>? a) {
  List<String> meh = [];
  a!.forEach((element) {
    if (element.type == 'size') {
      meh.add(element.value);
    }
  });
  return meh;
}
