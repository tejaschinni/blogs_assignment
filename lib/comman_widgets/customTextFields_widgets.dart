import 'package:flutter/material.dart';

class CustomTextFieldWidgets extends StatelessWidget {
  TextEditingController controller;
  String text;
  bool isVisible;
  CustomTextFieldWidgets(
      {super.key, required this.controller, required this.text,required this.isVisible});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.4,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextField(
        controller: controller,
        obscureText: isVisible,
        decoration: InputDecoration(
            hintText: text,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            )),
      ),
    );
  }
}
