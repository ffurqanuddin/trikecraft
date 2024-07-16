import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trikecraft/base/assets/app_fonts.dart';
import 'package:trikecraft/base/routes/app_routes.dart';
import 'package:trikecraft/base/services/hive/hive_services.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  int spTime = 4;

  @override
  void initState() {
    super.initState();
    //Remove the native splash screen
    FlutterNativeSplash.remove();
    redirect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/tricycle.jpg"),
            Container(
              height: 0.15.sh,
              width: 0.4.sw,
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 12.sp),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Trike",
                        style: TextStyle(
                          fontSize: 35.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      " Craft",
                      style: TextStyle(
                          fontSize: 45.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: AppFonts.poppins),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // --- Methods
  // Redirect to next page
  Future<void> redirect() async {
    await Future.delayed(Duration(seconds: spTime));
    if(await MyHiveBoxes.settingBox.get(MyHiveKeys.userIsLoggedIn) == true){
         Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.homeRoute,
      (route) => true,
    );
    } else{
  Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.landingRoute,
      (route) => true,
    );
    }
  
  }
}
