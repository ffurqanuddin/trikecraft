import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AuthButtonWidget extends StatelessWidget {
  AuthButtonWidget({
    super.key,
    required this.title,
    required this.showGoogleIcon,
    required this.onTap,
  });

  final bool showGoogleIcon;
 final String title;
  Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 0.05.sh,
        width: showGoogleIcon? 0.7.sw:0.4.sw,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.4),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.black26)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if(showGoogleIcon)const Icon(FontAwesomeIcons.google),
            Text(
              title??"",
              style: const TextStyle(
                  fontWeight: FontWeight.w500, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
