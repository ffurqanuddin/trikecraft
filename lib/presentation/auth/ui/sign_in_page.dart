import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:trikecraft/base/routes/app_routes.dart';
import 'package:trikecraft/common/glass_gradient_card_widget.dart';
import 'package:trikecraft/presentation/auth/widgets/auth_button_widget.dart';
import 'package:trikecraft/presentation/auth/widgets/auth_forgot_password_button.dart';
import 'package:trikecraft/presentation/auth/widgets/auth_page_bottom_buttons_widget.dart';
import 'package:trikecraft/presentation/auth/widgets/auth_page_heading_widget.dart';
import 'package:trikecraft/utils/email_validator_extension.dart';

import '../widgets/auth_form_field_widget.dart';
import '../widgets/neon_landscape_bg_widget.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  late final _emailController;
  late final _passwordController;
  late bool obscure;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    obscure = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: [
            //-- BG SKy Image
            const NeonLandscapeBackgroundWidget(),

            Center(
              child: FlipInY(
                child: GlassGradientCardWidget(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Gap(0.03.sh),

                        //-- Sign In Heading
                        FadeInDown(
                          child: AuthPageHeadingWidget(
                            mainHeading: "Sign In",
                            text: "Let's connect with us",
                          ),
                        ),

                        Gap(0.03.sh),

                        //---  Email Field
                        BounceInDown(
                          child: AuthFormFieldWidget(
                              controller: _emailController, hintText: "Email"),
                        ),
                        Gap(0.03.sh),
                        //--- Password Field
                        BounceInDown(
                          child: AuthFormFieldWidget(
                            controller: _passwordController,
                            hintText: "Password",
                            obscure: obscure,
                            suffix: TextButton(
                                onPressed: () {
                                  setState(() {
                                    obscure = !obscure;
                                  });
                                },
                                child: obscure
                                    ? const Text(
                                        "Show",
                                        style: TextStyle(color: Colors.white),
                                      )
                                    : const Text(
                                        "Hide",
                                        style: TextStyle(color: Colors.white),
                                      )),
                          ),
                        ),

                        ///---- Forget Password
                        FadeInRight(
                          child: AuthForgotPasswordButton(
                            onPressed: forgotPasswordMethod,
                          ),
                        ),

                        Gap(0.03.sh),

                        ///--- Sign In Button
                        FadeInUpBig(
                          child: AuthButtonWidget(
                              title: "Sign In",
                              showGoogleIcon: false,
                              onTap: signInButton),
                        ),

                        Gap(0.02.sh),
                        FadeOut(
                          child: const Text(
                            "OR",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),

                        Gap(0.02.sh),

                        ///--- Sign In Button
                        FadeInUp(
                          child: AuthButtonWidget(
                            showGoogleIcon: true,
                            title: "  Sign In with Google",
                            onTap: () {},
                          ),
                        ),

                        Gap(0.03.sh),

                        ///--- Bottom Nav Buttons
                        AuthPageBottomButtonsWidget(
                          firstTitle: 'New to TrikeCraft?',
                          buttonTitle: "Join Now",
                          buttonOnPressed: joinNowButtonOnPressed,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //---------- Methods ---------///
  void joinNowButtonOnPressed() {
    Navigator.pushNamed(context, AppRoutes.signUpRoute);
  }

  void forgotPasswordMethod() {
    Navigator.pushNamed(context, AppRoutes.forgotPasswordRoute);
  }

  void signInButton(){
     final email = _emailController.text.toString().trim();
    if (email.isValidEmail()) {
      print("The email is valid.");
    } else {
      print("The email is invalid.");
    }
  }
}
