import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GlassGradientCardWidget extends StatelessWidget {
  GlassGradientCardWidget({
    super.key,
    required this.child,
  });
  Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.88.sw,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.35),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white24),
      ),
      child: child
    
    );
  }
}
