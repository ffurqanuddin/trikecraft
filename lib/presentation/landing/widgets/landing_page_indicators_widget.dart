import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:trikecraft/models/landing_page_items_model.dart';

class LandingPageIndicatorsWidget extends StatelessWidget {
  const LandingPageIndicatorsWidget({
    super.key,
    required PageController pageController,
    required this.landingPageContentList,
  }) : _pageController = pageController;

  final PageController _pageController;
  final List<LandingPageItemsModel> landingPageContentList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SmoothPageIndicator(
          controller: _pageController,
          count: landingPageContentList.length,
          axisDirection: Axis.horizontal,
          effect: const ExpandingDotsEffect(
            activeDotColor: Colors.orange,
          ),
        ),
      ),
    );
  }
}
