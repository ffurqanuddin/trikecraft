import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trikecraft/admin/data/repository/admin_orders_repository.dart';
import 'package:trikecraft/admin/logic/admin_customizable_order/admin_customizable_orders_cubit.dart';
import 'package:trikecraft/admin/logic/admin_users_data/admin_users_data_cubit.dart';
import 'package:trikecraft/admin/logic/user_feedback/user_feedback_cubit.dart';
import 'package:trikecraft/base/routes/app_router.dart';
import 'package:trikecraft/base/routes/app_routes.dart';
import 'package:trikecraft/base/themes/app_themes.dart';
import 'package:trikecraft/data/repository/auth_repository.dart';
import 'package:trikecraft/data/repository/bikes_data_repository.dart';
import 'package:trikecraft/data/repository/change_user_profile_data_repository.dart';
import 'package:trikecraft/data/repository/firestore_order_data_repository.dart';
import 'package:trikecraft/data/repository/firestore_user_data_repository.dart';
import 'package:trikecraft/logic/auth/auth_bloc.dart';
import 'package:trikecraft/logic/available_pageview_changed/available_page_view_changed_cubit.dart';
import 'package:trikecraft/logic/change_user_profile/change_user_profile_cubit.dart';
import 'package:trikecraft/logic/check_internet/check_internet_bloc.dart';
import 'package:trikecraft/logic/current_user/current_user_bloc.dart';
import 'package:trikecraft/logic/customized_bike_order/customized_bike_order_bloc.dart';
import 'package:trikecraft/logic/greeting_text/greeting_cubit.dart';
import 'package:trikecraft/logic/all_available_bikes/available_bikes_bloc.dart';
import 'package:trikecraft/logic/theme/theme_cubit.dart';
import 'base/di/dependency_injection.dart';
import 'base/services/hive/hive_services.dart';
import 'firebase_options.dart';
import 'dart:developer' as developer;

import 'logic/user_feeback/user_feedback_cubit.dart';

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Initialize Get It
    getItSetup();

    // Initialize Hive Database
    await MyHive.initializeHive();

    // Setting preferred orientations
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    runApp(MyApp());
  }, (dynamic error, dynamic stack) {
    developer.log("Something went wrong!", error: error, stackTrace: stack);
  });
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
          create: (context) => CustomizedBikeOrderBloc(
              firestoreOrdersDataRepository:
                  getIt<FirestoreOrdersDataRepository>()),
        ),
        BlocProvider(
          create: (context) => AllAvailableBikesBloc(
              bikesDataRepository: getIt<BikesDataRepository>()),
        ),
        BlocProvider(
          create: (context) => AvailablePageViewChangedCubit(),
        ),
        BlocProvider(
          create: (context) => CheckInternetConnectionBloc(),
        ),
        BlocProvider(
          create: (context) => AdminCustomizableOrdersCubit(
              adminOrdersRepository: getIt<AdminOrdersRepository>()),
        ),
        BlocProvider(
          create: (context) => AdminUserFeedbackCubit(
              adminOrdersRepository: getIt<AdminOrdersRepository>()),
        ),
        BlocProvider(
          create: (context) => AdminUsersProfileDataCubit(
              adminOrdersRepository: getIt<AdminOrdersRepository>()),
        ),
        BlocProvider(
          create: (context) => UserFeedbackCubit(
              firestoreUserDataRepository:
                  getIt<FirestoreUserDataRepository>()),
        ),
        BlocProvider(
          create: (context) => ChangeUserProfileCubit(
              changeUserProfileDataRepository:
                  getIt<ChangeUserProfileDataRepository>()),
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
