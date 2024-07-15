import 'package:flutter/material.dart';

class AuthForgotPasswordButton extends StatelessWidget {
  AuthForgotPasswordButton({
    super.key,
    required this.onPressed
  });
  Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerRight,
        child: TextButton(
            onPressed: onPressed,
            child: Text(
              "Forgot Password",
              style: TextStyle(
                  color: Colors.white.withOpacity(0.9)),
            )));
  }
}
