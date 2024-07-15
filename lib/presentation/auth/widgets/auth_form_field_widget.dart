


import 'package:flutter/material.dart';

class AuthFormFieldWidget extends StatefulWidget {
  AuthFormFieldWidget(
      {super.key,
      required this.controller,
      required this.hintText,
      this.obscure = false,
      this.validator,
      this.suffix});

  final TextEditingController controller;
  final String hintText;
  final bool obscure;
  String? Function(String?)? validator;
  Widget? suffix;

  @override
  State<AuthFormFieldWidget> createState() => _AuthFormFieldWidgetState();
}

class _AuthFormFieldWidgetState extends State<AuthFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
      ),
      child: TextFormField(
        onTapOutside: (pointerDownEvent) {
          FocusScope.of(context).unfocus();
        },
        controller: widget.controller,
        maxLines: 1,
        obscureText: widget.obscure,
        validator: widget.validator,
        decoration: InputDecoration(
          hintText: widget.hintText,
          border: InputBorder.none,
          suffix: widget.suffix,
        ),
      ),
    );
  }
}
