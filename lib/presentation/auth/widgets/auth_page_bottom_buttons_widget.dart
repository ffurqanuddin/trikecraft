import 'package:flutter/material.dart';

class AuthPageBottomButtonsWidget extends StatelessWidget {
  AuthPageBottomButtonsWidget({
    super.key,
    required this.firstTitle,
    required this.buttonTitle,
    required this.buttonOnPressed,
  });

    String firstTitle;
   String buttonTitle;
   Function()? buttonOnPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          firstTitle,
          style: TextStyle(color: Colors.white70),
        ),
        TextButton(
            onPressed: buttonOnPressed,
            child: Text(
              buttonTitle,
              style: const TextStyle(
                  color: Color.fromARGB(255, 255, 0, 195)),
            ),),
      ],
    );
  }
}
