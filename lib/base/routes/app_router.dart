import 'package:flutter/material.dart';
import 'package:trikecraft/base/routes/app_routes.dart';
import 'package:trikecraft/presentation/splash/ui/splash_page.dart';

import '../../presentation/auth/ui/sign_in_page.dart';
import '../../presentation/auth/ui/sign_up_page.dart';
import '../../presentation/landing/ui/landing_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.homeRoute:

      // return MaterialPageRoute(builder: (_) => Home());
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
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
