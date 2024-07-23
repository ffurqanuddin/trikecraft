import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedIconButtonWidget extends StatelessWidget {
  CustomElevatedIconButtonWidget(
      {super.key,
      required this.label,
      required this.icon,
      required this.onPressed,
      this.margin,
      this.height,
      this.width});

  final String label;
  final IconData icon;
  Function()? onPressed;
  double? width;
  double? height;
  double? margin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(margin ?? 8.0),
      child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
              fixedSize: Size(width ?? 1.sw, height ?? 0.06.sh)),
          icon: Icon(icon),
          onPressed: onPressed,
          label: Text(label)),
    );
  }
}
