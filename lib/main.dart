import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trikecraft/base/routes/app_router.dart';
import 'package:trikecraft/base/routes/app_routes.dart';
import 'package:trikecraft/base/themes/app_themes.dart';
import 'base/di/dependency_injection.dart';
import 'base/services/hive/hive_services.dart';
import 'base/services/notification/app_notification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///--- Initialize Get It
  initializeLocator();

  ///--- Initialize Notification
  NotificationService().initNotification();

  //!  Initialize Hive Database
  await MyHive.initializeHive();

  //! Setting preferred orientations
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "TrikeCraft",
        theme: AppThemes.lightTheme,
        onGenerateRoute: AppRouter.generateRoute,
        initialRoute: AppRoutes.splashRoute,
      ),
    );
  }
}
