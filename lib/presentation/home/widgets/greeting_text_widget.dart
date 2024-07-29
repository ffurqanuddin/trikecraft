import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trikecraft/base/assets/app_fonts.dart';
import 'package:trikecraft/logic/greeting_text/greeting_cubit.dart';

import '../../../base/services/hive/hive_services.dart';

class GreetingTextWidget extends StatelessWidget {
  const GreetingTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GreetingCubit, GreetingState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              state.greeting,
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              userName() ?? "User",
              style: TextStyle(fontSize: 16, fontFamily: AppFonts.poppins),
            )
          ],
        );
      },
    );
  }

  String userName() {
    return MyHiveBoxes.settingBox.get(MyHiveKeys.userNameHiveKey);
  }
}
