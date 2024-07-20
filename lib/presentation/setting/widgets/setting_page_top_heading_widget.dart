import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingPageTopHeadingWidget extends StatelessWidget {
  const SettingPageTopHeadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ///?-------------------   TOP SETTING HEADING  -----------------------------///
        SizedBox(
          height: 0.1.sh,
          width: double.infinity,
          child: Text(
            " Settings",
            style: TextStyle(fontSize: 19.sp, letterSpacing: 1),
          ),
        ),
    
        ///!-------------------Theme SECTION-----------------------------///
        Row(
          children: [
            Text(
              "  APPEARANCE ",
              style: TextStyle(fontSize: 16.sp, letterSpacing: 1),
            ),
            const Icon(EvaIcons.colorPalette)
          ],
        ),
      ],
    );
  }
}
