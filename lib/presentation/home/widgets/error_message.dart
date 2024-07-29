import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trikecraft/logic/all_available_bikes/available_bikes_bloc.dart';

import '../../../base/assets/app_fonts.dart';

class ErrorMessage extends StatelessWidget {
  final AllAvailableBikesErrorState state;
  final VoidCallback onRefresh;

  const ErrorMessage({
    Key? key,
    required this.state,
    required this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Failed to load bikes: ${state.errorMessage}',
              style: TextStyle(
                fontSize: 16.sp,
                fontFamily: AppFonts.poppins,
                fontWeight: FontWeight.w500,
                color: Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.sp),
            ElevatedButton(
              onPressed: onRefresh,
              child: Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
