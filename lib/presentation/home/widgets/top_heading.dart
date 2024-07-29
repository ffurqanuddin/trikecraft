import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trikecraft/base/assets/app_fonts.dart';

class TopHeading extends StatelessWidget {
  const TopHeading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Available",
        style: TextStyle(
          fontSize: 23.sp,
          fontFamily: AppFonts.poppins,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
