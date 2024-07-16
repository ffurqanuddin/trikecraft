import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trikecraft/base/routes/app_router.dart';
import 'package:trikecraft/base/routes/app_routes.dart';
import 'package:trikecraft/base/themes/app_themes.dart';
import 'package:trikecraft/data/repository/auth_repository.dart';
import 'package:trikecraft/data/repository/firestore_repository.dart';
import 'package:trikecraft/logic/auth/auth_bloc.dart';
import 'base/di/dependency_injection.dart';
import 'base/services/hive/hive_services.dart';
import 'base/services/notification/app_notification.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  ///--- Initialize Get It
  getItSetup();

  ///--- Initialize Notification
  NotificationService().initNotification();

  //!  Initialize Hive Database
  await MyHive.initializeHive();

  //! Setting preferred orientations
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(
              authRepository: getIt<AuthRepository>(),
              firestoreRepository: getIt<FirestoreRepository>()),
        )
      ],
      child: ScreenUtilInit(
        splitScreenMode: true,
        builder: (context, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "TrikeCraft",
          theme: AppThemes.lightTheme,
          onGenerateRoute: AppRouter.generateRoute,
          initialRoute: AppRoutes.splashRoute,
        ),
      ),
    );
  }
}
