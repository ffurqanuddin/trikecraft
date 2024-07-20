import 'package:flutter/material.dart';
import 'package:trikecraft/base/routes/app_routes.dart';
import 'package:trikecraft/presentation/auth/ui/forgot_password_page.dart';
import 'package:trikecraft/presentation/craft_your_custom_bike/ui/craft_your_custom_bike_page.dart';
import 'package:trikecraft/presentation/my_orders/ui/my_orders_page.dart';
import 'package:trikecraft/presentation/setting/ui/settings_page.dart';
import 'package:trikecraft/presentation/splash/ui/splash_page.dart';

import '../../presentation/auth/ui/sign_in_page.dart';
import '../../presentation/auth/ui/sign_up_page.dart';
import '../../presentation/home/ui/home_page.dart';
import '../../presentation/landing/ui/landing_page.dart';
import '../../presentation/main/ui/main_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.homeRoute:
        return MaterialPageRoute(builder: (_) => HomePage());
      case AppRoutes.mainRoute:
        return MaterialPageRoute(builder: (_) => MainPage());
      case AppRoutes.splashRoute:
        // var data = settings.arguments;
        return MaterialPageRoute(builder: (_) => const SplashPage());

      case AppRoutes.landingRoute:
        // var data = settings.arguments;
        return MaterialPageRoute(builder: (_) => const LandingPage());

      case AppRoutes.signInRoute:
        return MaterialPageRoute(builder: (_) => const SignInPage());

      case AppRoutes.signUpRoute:
        return MaterialPageRoute(builder: (_) => const SignUpPage());

      case AppRoutes.forgotPasswordRoute:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordPage());

      case AppRoutes.settingRoute:
        return MaterialPageRoute(builder: (_) => const SettingsPage());
      case AppRoutes.myOrdersRoute:
        return MaterialPageRoute(builder: (_) => const MyOrdersPage());

      case AppRoutes.craftYourCustomBikeRoute:
        return MaterialPageRoute(
            builder: (_) => const CraftYourCustomBikePage());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
