import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:trikecraft/common/glass_gradient_card_widget.dart';
import 'package:trikecraft/utils/email_validator_extension.dart';

import '../widgets/auth_button_widget.dart';
import '../widgets/auth_form_field_widget.dart';
import '../widgets/auth_page_heading_widget.dart';
import '../widgets/neon_landscape_bg_widget.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  late final _emailController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        alignment: Alignment.center,
        children: [
          //-- BG SKy Image
          const NeonLandscapeBackgroundWidget(),

          GlassGradientCardWidget(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 9.sp),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Gap(0.03.sh),

                //--  Heading
                FadeInDown(
                  child: AuthPageHeadingWidget(
                    mainHeading: "Forgot Password",
                    text:
                        "\nDon't worry sometimes people can forgot too, enter your email and we will  send a password reset link.",
                  ),
                ),

                Gap(0.03.sh),

                //---  Email Field
                BounceInDown(
                  child: AuthFormFieldWidget(
                      controller: _emailController, hintText: "Email"),
                ),

                Gap(0.03.sh),

                ///--- Submit Button
                FadeInUpBig(
                  child: AuthButtonWidget(
                      title: "Submit",
                      showGoogleIcon: false,
                      onTap: submitButtonMethod),
                ),

                Gap(0.03.sh),
              ],
            ),
          )),
        ],
      ),
    );
  }

  //------------- M E T H O D S ---------------///

  void submitButtonMethod() async {
    final email = _emailController.text.toString().trim();
    if (email.isValidEmail()) {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.trim(),);
      Fluttertoast.showToast(
          msg:
              "Email has been sent to your email, please check your inbox/spam box");
      Navigator.pop(context);
    } else {
      print("The email is invalid.");
    }
  }
}
