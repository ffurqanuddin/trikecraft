


  import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:trikecraft/base/routes/app_routes.dart';

import '../../../base/assets/app_fonts.dart';
import 'greeting_text_widget.dart';
import 'profile_avatar_widget.dart';
import '../../../common/theme_mode_change_button_widget.dart';

AppBar HomeAppBar(context) {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 0.12.sh,
      actions: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: 10.sp),
            child: Row(
              children: [
                ///---- Avatar
                SpinPerfect(child: ProfileAvatarWidget()),

                Gap(10.sp),

                ///----- Greeting Text
                FadeInDown(child: GreetingTextWidget()),

                Spacer(),

                ///--- Dark/Light Mode Button
                FadeInRight(child: ThemeModeChangeButtonWidget()),
              ],
            ),
          ),
        ),
      ],

      //---------  Bottom ----------------///
      bottom: PreferredSize(
        preferredSize: Size(1.sw, 0.1.sh),
        child: Row(
          children: [
            Expanded(
              child: Pulse(
                child: GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, AppRoutes.searchProductsPageRoute);
                  },
                  child: Container(
                      padding: EdgeInsets.symmetric(vertical: 5.sp),
                      margin: EdgeInsets.symmetric(
                          horizontal: 10.sp, vertical: 15.sp),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.white70),
                      ),
                      child: Text(
                        "Search Bikes",
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontFamily: AppFonts.poppins,
                            color: Colors.white70),
                      )),
                ),
              ),
            ),
            // IconButton(
            //     onPressed: () {},
            //     icon: Icon(
            //       FontAwesomeIcons.filter,
            //       color: Colors.white,
            //     ))
          ],
        ),
      ),
    );
  }