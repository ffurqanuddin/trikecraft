import 'package:flutter/material.dart';
import 'package:trikecraft/base/assets/app_fonts.dart';

class CustomLandingTextWIdget extends StatelessWidget {
  const CustomLandingTextWIdget(
      {super.key,
      required this.text,
      required this.size,
      required this.weight});

  final String text;
  final double size;
  final FontWeight weight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: size,
          fontWeight: weight,
          fontFamily: AppFonts.poppins,
          color: Colors.white,
          shadows: const [
            Shadow(color: Colors.black, blurRadius: 10, offset: Offset(1, 0),)
          ]),
    );
  }
}
