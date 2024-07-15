import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trikecraft/common/glass_gradient_card_widget.dart';
import 'package:trikecraft/presentation/landing/widgets/custom_landing_text_widget.dart';

class LandingPageWidget extends StatelessWidget {
  const LandingPageWidget(
      {super.key,
      required this.headTitle,
      required this.description,
      required this.image,
      });

  final String image;
  final String headTitle;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// BG Image
        Container(
          height: 1.sh,
          width: 1.sw,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    image,
                  ),
                  fit: BoxFit.fill)),
        ),

        // Title & Description
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.all(20),
            margin: EdgeInsets.only(bottom: 0.16.sh),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FadeInDown(
                  child: CustomLandingTextWIdget(
                    text: headTitle,
                    size: 39.sp,
                    weight: FontWeight.bold,
                  ),
                ),
                FadeInRight(
                  child: GlassGradientCardWidget(
                  
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomLandingTextWIdget(
                        text: description,
                        size: 18.sp,
                        weight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
