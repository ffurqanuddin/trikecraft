import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trikecraft/base/routes/app_routes.dart';
import 'package:trikecraft/logic/all_available_bikes/available_bikes_bloc.dart';
import 'package:trikecraft/logic/available_pageview_changed/available_page_view_changed_cubit.dart';
import 'package:trikecraft/logic/carouselslider_indicator/carousel_slider_indicator_cubit.dart';
import 'package:trikecraft/presentation/home/widgets/available_widget.dart';
import 'package:trikecraft/presentation/home/widgets/bike_card.dart';

class LoadedBikesView extends StatelessWidget {
  final AllAvailableBikesSuccessState state;

  final Function(int) onPageChanged;

  const LoadedBikesView({
    Key? key,
    required this.state,
    required this.onPageChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.42.sh,
      child: BlocBuilder<AvailablePageViewChangedCubit,
          AvailablePageViewChangedState>(
        builder: (context, pageState) {
          return CarouselSlider(
            items: state.bikes
                .map(
                  (e) => GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.productViewRoute,
                          arguments: e);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: BikeCard(bike: e),
                    ),
                  ),
                )
                .toList(),
            options: CarouselOptions(
              onPageChanged: (index, reason) {
                print(index);
                context
                    .read<CarouselSliderIndicatorCubit>()
                    .updateIndicatorIndex(index);
              },
              height: 0.38.sh,
              aspectRatio: 16 / 9,
              viewportFraction: 0.8,
              initialPage: 0,
              enableInfiniteScroll: true,
              pauseAutoPlayOnManualNavigate: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
              pauseAutoPlayOnTouch: true,
              scrollDirection: Axis.horizontal,
            ),
          );
        },
      ),
    );
  }
}
