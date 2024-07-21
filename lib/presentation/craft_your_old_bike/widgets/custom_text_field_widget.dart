import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatelessWidget {
  CustomTextFieldWidget(
      {super.key,
      required this.controller,
      required this.hintText,
      this.maxLength});

  final TextEditingController controller;
  final String hintText;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          child: TextField(
        controller: controller,
        maxLines: 5,
        minLines: 1,
        maxLength: maxLength ?? 200,
        onTapOutside: (val) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        decoration:
            InputDecoration(border: InputBorder.none, hintText: hintText),
      )),
    );
  }
}
