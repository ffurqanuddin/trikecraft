import 'package:animate_do/animate_do.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:trikecraft/base/routes/app_routes.dart';
import 'package:trikecraft/logic/auth/auth_bloc.dart';
import 'package:trikecraft/logic/theme/theme_cubit.dart';
import 'package:trikecraft/presentation/setting/widgets/change_theme_expansion_tile_widget.dart';
import 'package:trikecraft/presentation/setting/widgets/change_theme_list_tile_widget.dart';
import 'package:trikecraft/presentation/setting/widgets/dark_mode_switch_list_tile_widget.dart';
import 'package:trikecraft/presentation/setting/widgets/setting_page_top_heading_widget.dart';

import '../widgets/licenses_widget.dart';
import '../widgets/setting_list_tile_widget.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.05.sw, vertical: 0.05.sh),
          child: SlideInDown(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///?-------------------TOP SECTION-----------------------------///
                SettingPageTopHeadingWidget(),

                SizedBox(
                  height: 0.01.sh,
                ),

                ///!-------------------Change Theme Expansion Tile-----------------------------///
                ChangeThemeExpansionTileWidget(),

                ///!-------------------Dark Mode Switch Tile-----------------------------///
                DarkModeSwitchListTileWidget(),

                Gap(0.02.sh),

                ///?-------------------GENERAL SECTION-----------------------------///
                Text(
                  "  GENERAL",
                  style: TextStyle(fontSize: 16.sp, letterSpacing: 1.5),
                ),

                Gap(0.01.sh),

                ///!-------------------Profile-----------------------------///
                SettingsListTileWidget(
                  title: "Profile",
                  iconData: CupertinoIcons.person,
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.userProfileRoute);
                  },
                ),

                _divider(),

                ///!-------------------Feedback-----------------------------///
                SettingsListTileWidget(
                  title: "Feedback",
                  iconData: Icons.feedback,
                  onTap: () {
                    Navigator.pushNamed(
                        context, AppRoutes.UserFeedbackPageRoute);
                  },
                ),

                _divider(),

                ///!------------------- Licenses-----------------------------///
                const LicenceWidget(),

                _divider(),

                ///!-------------------About-----------------------------///
                SettingsListTileWidget(
                    title: "About",
                    iconData: CupertinoIcons.info,
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.aboutPageRoute);
                    }),

                _divider(),

                ///!-------------------Logout-----------------------------///
                SettingsListTileWidget(
                    title: "Logout",
                    iconData: FontAwesomeIcons.arrowRightFromBracket,
                    onTap: logOut),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Divider _divider() {
    return const Divider();
  }
  ////////////////////!//////////////////////////////////////////////////
  ///?------------------------    M E T H O D S  --------------------///
  //!/////////////////////////////////////////////////////////////////////

  logOut() {
    showDialog(
        context: context,
        builder: (context) => Dialog(
              alignment: Alignment.center,
              shape: CircleBorder(),
              child: Center(
                child: Container(
                  height: 0.2.sh,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Are you sure",
                          style: TextStyle(
                            fontSize: 22.sp,
                          ),
                        ),
                        Gap(10),
                        ElevatedButton.icon(
                            icon: Icon(Icons.logout),
                            onPressed: () {
                              context
                                  .read<AuthBloc>()
                                  .add(LogOutEvent(context: context));
                            },
                            label: Text("LogOut Now"))
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }

  ///!------------ Feedback On Tap
}
