import 'package:flutter/material.dart';
import 'package:trikecraft/admin/presentation/customized_orders_preview/ui/admin_customized_order_preview.dart';
import 'package:trikecraft/admin/presentation/feedbacks/ui/admin_user_feebacks_page.dart';
import 'package:trikecraft/admin/presentation/products/ui/admin_add_new_product_page.dart';
import 'package:trikecraft/admin/presentation/products/ui/admin_products_page.dart';
import 'package:trikecraft/admin/presentation/users_profile/ui/users_profile_page.dart';
import 'package:trikecraft/base/routes/app_routes.dart';
import 'package:trikecraft/models/bike_model.dart';
import 'package:trikecraft/admin/presentation/dashboard/ui/admin_dashboard.dart';
import 'package:trikecraft/models/customization_order_model.dart';
import 'package:trikecraft/models/order_model.dart';
import 'package:trikecraft/presentation/about/ui/about_page.dart';
import 'package:trikecraft/presentation/auth/ui/forgot_password_page.dart';
import 'package:trikecraft/presentation/craft_your_old_bike/ui/craft_your_old_bike_page.dart';
import 'package:trikecraft/presentation/feedback/ui/user_feeback_page.dart';
import 'package:trikecraft/presentation/my_orders/ui/my_orders_page.dart';
import 'package:trikecraft/presentation/payment/ui/easypaisa_payment_page.dart';
import 'package:trikecraft/presentation/payment/ui/p2p_payment_page.dart';
import 'package:trikecraft/presentation/product_view/ui/product_view.dart';
import 'package:trikecraft/presentation/search_products/ui/search_products_page.dart';
import 'package:trikecraft/presentation/setting/ui/settings_page.dart';
import 'package:trikecraft/presentation/splash/ui/splash_page.dart';
import 'package:trikecraft/presentation/user_profile/ui/profile_page.dart';

import '../../admin/presentation/new_orders_preview/ui/admin_new_bikes_orders_preview_page.dart';
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

      case AppRoutes.userProfileRoute:
        return MaterialPageRoute(builder: (_) => const ProfilePage());



      case AppRoutes.aboutPageRoute:
        return MaterialPageRoute(builder: (_) => const AboutPage());

      case AppRoutes.productViewRoute:
        var argument = settings.arguments as BikeModel;
        var bike = argument;

        return MaterialPageRoute(
          builder: (_) => ProductViewPage(bike: bike),
        );

      case AppRoutes.adminCustomizedBikesOrderPreviewPage:
        var arguments = settings.arguments as List<CustomizationOrderModel>;

        return MaterialPageRoute(
          builder: (_) => AdminCustomizedBikesOrderPreviewPage(
            ordersList: arguments,
          ),
        );

         case AppRoutes.adminNewBikesOrderPreviewPage:
        var arguments = settings.arguments as List<NewBikeOrderModel>;

        return MaterialPageRoute(
          builder: (_) => AdminNewBikesOrderPreviewPage(
            ordersList: arguments,
          ),
        );

      case AppRoutes.easypaisaPaymentPageRoute:
        var argument = settings.arguments as BikeModel;

        return MaterialPageRoute(
            builder: (_) => EasypaisaPaymentPage(
                  bike: argument,
                ));


      case AppRoutes.p2pPaymentPageRoute:
        var argument = settings.arguments as BikeModel;

        return MaterialPageRoute(
            builder: (_) => P2PPaymentPage(
                  bike: argument,
                ));

      case AppRoutes.adminUserFeedbacksRoute:
        return MaterialPageRoute(
          builder: (_) => AdminUserFeedbacksPage(),
        );
      case AppRoutes.adminDashboardRoute:
        return MaterialPageRoute(builder: (_) => const AdminDashboardPage());

      case AppRoutes.adminUserProfileRoute:
        return MaterialPageRoute(builder: (_) => const AdminUsersProfilePage());

      case AppRoutes.UserFeedbackPageRoute:
        return MaterialPageRoute(builder: (_) => UserFeedbackPage());

          case AppRoutes.adminProductsRoute:
        return MaterialPageRoute(builder: (_) => AdminProductsPage());

          case AppRoutes.adminAddNewProductRoute:
        return MaterialPageRoute(builder: (_) => AdminAddNewProductPage());
      case AppRoutes.searchProductsPageRoute:
        return MaterialPageRoute(builder: (_) => SearchProductsPage());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
