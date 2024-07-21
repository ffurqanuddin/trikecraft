import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:trikecraft/base/assets/app_fonts.dart';

class TextDetailWidget extends StatelessWidget {
  const TextDetailWidget(
      {super.key, required this.heading, required this.controller});

  final String heading;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16.sp,
            ),
          ),
          Gap(3),
          Text(controller.text.isEmpty
              ? "none"
              : controller.text.toString().trim())
        ],
      ),
    );
  }
}
