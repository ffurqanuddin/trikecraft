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

import '../widgets/auth_form_field_widget.dart';
import '../widgets/neon_landscape_bg_widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  late final _fullNameController;
  late final _emailController;
  late final _passwordController;
  late final _confirmPasswordController;
  late bool obscure;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _fullNameController = TextEditingController();
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
                
                        //-- Sign Up Heading
                        FadeInDown(
                          child: AuthPageHeadingWidget(
                            mainHeading: "Sign Up",
                            text: "Let's connect with us",
                          ),
                        ),
                
                        Gap(0.03.sh),
                
                        //---  Full Field
                        FadeInDown(
                          child: AuthFormFieldWidget(
                              controller: _fullNameController,
                              hintText: "Full Name"),
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
                        Gap(0.03.sh),
                        //--- Confirm Password Field
                        BounceInDown(
                          child: AuthFormFieldWidget(
                            controller: _confirmPasswordController,
                            hintText: "Confirm Password",
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
                
                        Gap(0.03.sh),
                
                        ///--- Sign Up Button
                        FadeInUpBig(
                          child: AuthButtonWidget(
                              title: "Sign Up",
                              showGoogleIcon: false,
                              onTap: () {}),
                        ),
                
                        Gap(0.02.sh),
                        FadeOut(
                          child: const Text(
                            "OR",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                
                        Gap(0.02.sh),
                
                        ///--- Sign Up Button
                        FadeInUp(
                          child: AuthButtonWidget(
                            showGoogleIcon: true,
                            title: "  Sign Up with Google",
                            onTap: () {},
                          ),
                        ),
                
                        Gap(0.03.sh),
                
                        ///--- Bottom Nav Buttons
                        AuthPageBottomButtonsWidget(
                          firstTitle: 'Already In TrikeCraft?',
                          buttonTitle: "Login Now",
                          buttonOnPressed: loginNowButtonOnPressed,
                        )
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
  void loginNowButtonOnPressed() {
    Navigator.pushNamed(context, AppRoutes.signInRoute);
  }
}
