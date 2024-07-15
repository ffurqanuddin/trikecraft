import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trikecraft/base/routes/app_routes.dart';

class GetStartedButtonWidget extends StatelessWidget {
  const GetStartedButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: InkWell(
          onTap: () {
            Navigator.pushReplacementNamed(
                context, AppRoutes.signInRoute);
          },
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: 30.sp, vertical: 12.sp),
            margin:  EdgeInsets.only(bottom: 25.sp),
            decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(30)),
            child: Text(
              "Get Started",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 25.sp),
            ),
          ),
        ),
      ),
    );
  }
}
