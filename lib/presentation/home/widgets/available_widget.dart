import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:trikecraft/logic/available_pageview_changed/available_page_view_changed_cubit.dart';
import 'package:trikecraft/presentation/home/widgets/error_message.dart';
import 'package:trikecraft/presentation/home/widgets/loaded_bikes_view.dart';
import 'package:trikecraft/presentation/home/widgets/loading_shimmer_of_home_bike_card.dart';
import 'package:trikecraft/presentation/home/widgets/top_heading.dart';
import '../../../logic/all_available_bikes/available_bikes_bloc.dart';

class AvailableWidget extends StatefulWidget {
  const AvailableWidget({Key? key}) : super(key: key);

  @override
  State<AvailableWidget> createState() => _AvailableWidgetState();
}

class _AvailableWidgetState extends State<AvailableWidget> {
  late PageController _pageViewController;
  late int _pageIndex;

  @override
  void initState() {
    super.initState();
    context
        .read<AllAvailableBikesBloc>()
        .add(FetchAllAvailableBikesListEvent());
    _pageIndex = 0;
    _pageViewController = PageController(initialPage: _pageIndex);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllAvailableBikesBloc, AllAvailableBikesState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Gap(0.02.sh),

            ///------------ Heading ------------///
            const TopHeading(),

            Gap(0.01.sh),

            if (state is AllAvailableBikesLoadingState)
              const LoadingShimmerOfHomeBikeCard(),

            if (state is AllAvailableBikesSuccessState)
              LoadedBikesView(
                state: state,
                pageViewController: _pageViewController,
                onPageChanged: onPageChanged,
              ),

            if (state is AllAvailableBikesSuccessState)
              Padding(
                padding: EdgeInsets.all(10.sp),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SmoothPageIndicator(
                    controller: _pageViewController,
                    count: state.bikes.length,
                    axisDirection: Axis.horizontal,
                    effect: ExpandingDotsEffect(
                      activeDotColor: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),

            if (state is AllAvailableBikesErrorState)
              ErrorMessage(
                  state: state,
                  onRefresh: () {
                    initState();
                  }),
          ],
        );
      },
    );
  }

  void onPageChanged(int index) {
    context.read<AvailablePageViewChangedCubit>().changedPage(index);
  }
}
