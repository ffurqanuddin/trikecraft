import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:trikecraft/base/assets/app_fonts.dart';
import 'package:trikecraft/logic/available_pageview_changed/available_page_view_changed_cubit.dart';
import '../../../logic/available_bikes/available_bikes_bloc.dart';

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
    context.read<AvailableBikesBloc>().add(FetchAvailableBikesListEvent());
    _pageIndex = 0;
    _pageViewController = PageController(initialPage: _pageIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<AvailableBikesBloc, AvailableBikesState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gap(0.02.sh),

              ///------------ Heading ------------///
              Center(
                child: Text(
                  "Available",
                  style: TextStyle(
                    fontSize: 23.sp,
                    fontFamily: AppFonts.poppins,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Gap(0.01.sh),

              ///-------------  Loading ------------------///
              if (state is AvailableBikesLoadingState)
                const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),

              ///----------- If Loaded Successfully  --------------///
              if (state is AvailableBikesSuccessState)
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: BlocBuilder<AvailablePageViewChangedCubit,
                            AvailablePageViewChangedState>(
                        builder: (context, pageState) {
                      return PageView.builder(
                        scrollDirection: Axis.horizontal,
                        controller: _pageViewController,
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.bikes.length,
                        onPageChanged: onPageChanged,
                        itemBuilder: (context, index) {
                          final bike = state.bikes[pageState.pageIndex];

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 0.25.sh,
                              width: 0.9.sw,
                              decoration: BoxDecoration(
                                color: Colors.white,

                                //------------------------ Bike Picture --------------///
                                image: DecorationImage(
                                  image:
                                      CachedNetworkImageProvider(bike.picture),
                                  fit: BoxFit.contain,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Stack(
                                children: [
                                  //------------------------ Bike Company --------------///
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: FadeInLeft(
                                      child: Container(
                                        padding: const EdgeInsets.all(2),
                                        margin: const EdgeInsets.only(
                                            top: 20, left: 10),
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 238, 0, 255),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          " ${bike.company} ",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  //------------------------ Bike Model --------------///
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: FadeInRight(
                                      child: Container(
                                        padding: const EdgeInsets.all(6),
                                        margin: const EdgeInsets.only(
                                            top: 20, right: 10),
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 255, 213, 0),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          "Model ${bike.model} ",
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  //------------------------ Bike Price --------------///
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: FadeInRight(
                                      child: Container(
                                        padding: const EdgeInsets.all(2),
                                        margin: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          "Price ${bike.price} PKR ",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15.sp,
                                            fontFamily: AppFonts.poppins,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }),
                  ),
                ),
              if (state is AvailableBikesSuccessState)

                ///-----------------  Dot Indicators ------------------///
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

              ///-----------------  If Error ---------------///
              if (state is AvailableBikesErrorState)
                Expanded(
                  child: Center(
                    child: Text(
                      'Failed to load bikes: ${state.errorMessage}',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontFamily: AppFonts.poppins,
                        fontWeight: FontWeight.w500,
                        color: Colors.red,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  void onPageChanged(int index) {
    context.read<AvailablePageViewChangedCubit>().changedPage(index);
  }
}
