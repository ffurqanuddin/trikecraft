import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:trikecraft/base/assets/app_images.dart';
import 'package:trikecraft/base/contents/app_contents.dart';
import 'package:trikecraft/base/routes/app_routes.dart';
import 'package:trikecraft/presentation/landing/widgets/get_started_button_widget.dart';
import 'package:trikecraft/presentation/landing/widgets/landing_page_indicators_widget.dart';
import 'package:trikecraft/presentation/landing/widgets/landing_page_widget.dart';

import '../../../data/models/landing_page_items_model.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late int pageIndex;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    pageIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    //----- Landing Page Content List
    final landingPageContentList = [
      LandingPageItemsModel(
        title: AppContents.landingPage1Title,
        description: AppContents.landingPage1Description,
        image: AppImages.landingPage1Image,
      ),
      LandingPageItemsModel(
        title: AppContents.landingPage2Title,
        description: AppContents.landingPage2Description,
        image: AppImages.landingPage2Image,
      ),
      LandingPageItemsModel(
        title: AppContents.landingPage3Title,
        description: AppContents.landingPage3Descripiton,
        image: AppImages.landingPage3Image,
      ),
    ];

    return Scaffold(
      body: Stack(
        children: [
          //---------- PageView Builder -------------///
          PageView.builder(
            controller: _pageController,
            onPageChanged: onPageChanged,
            itemCount: landingPageContentList.length,
            itemBuilder: (context, index) => LandingPageWidget(
              headTitle: landingPageContentList[pageIndex].title,
              description: landingPageContentList[pageIndex].description,
              image: landingPageContentList[pageIndex].image,
            ),
          ),

          ///------------- Indicators ---------
          if (pageIndex < 2)
            LandingPageIndicatorsWidget(
                pageController: _pageController,
                landingPageContentList: landingPageContentList),

          ///---------- Get Stareted ------------///
          if (pageIndex == 2) const GetStartedButtonWidget(),
        ],
      ),
    );
  }

  //-------------------    Methods  ------------------------------///
  void onPageChanged(index) {
    setState(() {
      pageIndex = index;
    });
  }
}
