import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trikecraft/base/routes/app_router.dart';
import 'package:trikecraft/base/routes/app_routes.dart';
import 'package:trikecraft/base/themes/app_themes.dart';
import 'package:trikecraft/data/repository/auth_repository.dart';
import 'package:trikecraft/data/repository/bikes_data_repository.dart';
import 'package:trikecraft/data/repository/firestore_order_data_repository.dart';
import 'package:trikecraft/data/repository/firestore_user_data_repository.dart';
import 'package:trikecraft/logic/auth/auth_bloc.dart';
import 'package:trikecraft/logic/current_user/current_user_bloc.dart';
import 'package:trikecraft/logic/customized_bike_order/customized_bike_order_bloc.dart';
import 'package:trikecraft/logic/greeting_text/greeting_cubit.dart';
import 'package:trikecraft/logic/available_bikes/available_bikes_bloc.dart';
import 'package:trikecraft/logic/theme/theme_cubit.dart';
import 'base/di/dependency_injection.dart';
import 'base/services/hive/hive_services.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  ///--- Initialize Get It
  getItSetup();

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
              firestoreRepository: getIt<FirestoreUserDataRepository>()),
        ),
        BlocProvider(
          create: (context) => CurrentUserBloc(
              firestoreRepository: getIt<FirestoreUserDataRepository>()),
        ),
        BlocProvider(
          create: (context) => ThemeCubit(),
        ),
        BlocProvider(
          create: (context) => GreetingCubit(),
        ),
        BlocProvider(
          create: (context) => AvailableBikesBloc(
              bikesDataRepository: getIt<BikesDataRepository>()),
        ),
        BlocProvider(
          create: (context) => CustomizedBikeOrderBloc(
              firestoreOrdersDataRepository:
                  getIt<FirestoreOrdersDataRepository>()),
        ),
        BlocProvider(
          create: (context) => AvailableBikesBloc(
              bikesDataRepository: getIt<BikesDataRepository>()),
        ),
      ],
      child: ScreenUtilInit(
        splitScreenMode: true,
        builder: (context, child) => BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: "TrikeCraft",
              theme: state.isDarkMode
                  ? AppThemes.DarkThemeList[state.themeIndex]
                  : AppThemes.LightThemeList[state.themeIndex],
              onGenerateRoute: AppRouter.generateRoute,
              initialRoute: AppRoutes.splashRoute,
            );
          },
        ),
      ),
    );
  }
}
