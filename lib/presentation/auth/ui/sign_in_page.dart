import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:one_context/one_context.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:trikecraft/base/di/dependency_injection.dart';
import 'package:trikecraft/base/routes/app_routes.dart';
import 'package:trikecraft/base/services/hive/hive_services.dart';
import 'package:trikecraft/common/glass_gradient_card_widget.dart';
import 'package:trikecraft/data/repository/firestore_user_data_repository.dart';
import 'package:trikecraft/logic/auth/auth_bloc.dart';
import 'package:trikecraft/logic/check_internet/check_internet_state.dart';
import 'package:trikecraft/logic/theme/theme_cubit.dart';
import 'package:trikecraft/presentation/auth/widgets/auth_button_widget.dart';
import 'package:trikecraft/presentation/auth/widgets/auth_forgot_password_button.dart';
import 'package:trikecraft/presentation/auth/widgets/auth_page_bottom_buttons_widget.dart';
import 'package:trikecraft/presentation/auth/widgets/auth_page_heading_widget.dart';
import 'package:trikecraft/utils/email_validator_extension.dart';
import 'package:trikecraft/utils/snackbars.dart';

import '../../../logic/check_internet/check_internet_bloc.dart';
import '../widgets/auth_form_field_widget.dart';
import '../widgets/neon_landscape_bg_widget.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late bool obscure;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    obscure = true;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) async {
            if (state is AuthSuccessState) {
              if (await MyHiveBoxes.settingBox
                      .get(MyHiveKeys.isAdminLoggedIn) ??
                  await getIt<FirestoreUserDataRepository>()
                      .checkUserIsAdmin()) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.adminDashboardRoute,
                  (route) => false,
                );

                context.read<ThemeCubit>().toggleTheme();
              } else {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.mainRoute,
                  (route) => false,
                );
                // Close all dialogs and progress indicators
              Navigator.of(context, rootNavigator: true)
                  .popUntil((route) => route.isFirst);
              }
            }

            if (state is AuthFailureState) {
              Fluttertoast.showToast(
                msg: state.errorMessage,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.red,
                textColor: Colors.white,
              );
              // Close all dialogs and progress indicators
              Navigator.of(context, rootNavigator: true)
                  .popUntil((route) => route.isFirst);
            }

            if (state is AuthLoadingState) {
              _loadingDialog(context);
            }
          },
          builder: (context, state) {
            return BlocConsumer<CheckInternetConnectionBloc,
                CheckInternetConnectionState>(
              listener: (context, internetState) {
                if (internetState is NoInternetConnectionState) {
                  MySnackbars.showErrorSnackbar(context,
                      message:
                          "Please make sure your internet connection is on !");
                }
              },
              builder: (context, state) {
                return Stack(
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
                                    controller: _emailController,
                                    hintText: "Email",
                                    validator: (str) {
                                      if (str!.isEmpty) {
                                        return "Please fill the email";
                                      }
                                    },
                                  ),
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
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )
                                            : const Text(
                                                "Hide",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                    validator: (str) {
                                      if (str!.isEmpty) {
                                        return "Please fill the password";
                                      }
                                      if (str.isNotEmpty && str.length < 6) {
                                        return "Password must be minimum 6 character long";
                                      }
                                    },
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
                                // if (state is! AuthLoadingState )
                                FadeInUpBig(
                                  child: AuthButtonWidget(
                                      title: "Sign In",
                                      showGoogleIcon: false,
                                      onTap: signInButton),
                                ),

                                Gap(0.02.sh),
                                // if (state is! AuthLoadingState )
                                FadeIn(
                                  child: const Text(
                                    "OR",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),

                                Gap(0.02.sh),

                                ///--- Sign In Button
                                // if (state is! AuthLoadingState)
                                FadeInUp(
                                  child: AuthButtonWidget(
                                    showGoogleIcon: true,
                                    title: "  Sign In with Google",
                                    onTap: signInWithGoogle,
                                  ),
                                ),

                                //------ Loading Indicators -----------///
                                // if (state is AuthLoadingState )
                                //   SizedBox(
                                //     child: CircularProgressIndicator(
                                //       color: Colors.white,
                                //     ),
                                //   ),

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
                );
              },
            );
          },
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

  void signInButton() {
    final email = _emailController.text.toString().trim();
    final password = _passwordController.text.toString().trim();
    print("\nEmail is : " + email);
    print("\nPassword is : " + password);
    if (_formKey.currentState!.validate()) {
      if (email.isValidEmail()) {
        context.read<AuthBloc>().add(SignInWithEmailEvent(
              email: email,
              password: password,
            ));
      } else {
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.error(
            message: "Email is not valid",
            maxLines: 1,
            textStyle: TextStyle(fontSize: 14.sp),
          ),
        );
      }
    }
  }

  signInWithGoogle() {
    context.read<AuthBloc>().add(AuthWithGoogleEvent());
  }

  void _loadingDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Dialog(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              alignment: Alignment.center,
              child: Center(
                child: Center(
                    child: CircularProgressIndicator(
                  color: Colors.white,
                )),
              ),
            ));
  }
}
