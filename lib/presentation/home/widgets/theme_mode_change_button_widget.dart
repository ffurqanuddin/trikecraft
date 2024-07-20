import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trikecraft/logic/theme/theme_cubit.dart';

class ThemeModeChangeButtonWidget extends StatelessWidget {
  const ThemeModeChangeButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: () {
              context.read<ThemeCubit>().toggleTheme();
              print("\n Toggle Theme Button is Pressed \n");
            },
            icon: Icon(
              state.isDarkMode ? Icons.sunny : Icons.dark_mode,
              size: 30.sp,
            ),
          ),
        );
      },
    );
  }
}
