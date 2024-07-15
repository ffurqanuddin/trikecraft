import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../base/assets/app_images.dart';

class NeonLandscapeBackgroundWidget extends StatelessWidget {
  const  NeonLandscapeBackgroundWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
     height: 1.sh,
     width: 1.sw,
     decoration: const BoxDecoration(
       image: DecorationImage(image: AssetImage(AppImages.neonLandscape,), fit: BoxFit.fill)
     ),
    );
  }
}