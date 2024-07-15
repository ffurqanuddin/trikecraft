import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthPageHeadingWidget extends StatelessWidget {
  AuthPageHeadingWidget({
    super.key,
    required this.mainHeading,
    required this.text,
  });

  String mainHeading;
  String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          mainHeading,
          style: TextStyle(fontSize: 29.spMax),
        ),

        //-- Des
        Text(
          text,
          style: TextStyle(fontSize: 14.spMax),
        ),
      ],
    );
  }
}
