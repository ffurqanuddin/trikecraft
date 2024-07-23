import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:trikecraft/base/assets/app_fonts.dart';
import 'package:trikecraft/base/routes/app_routes.dart';
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
    return BlocBuilder<AvailableBikesBloc, AvailableBikesState>(
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
              Center(
                child: CircularProgressIndicator(),
              ),

            ///----------- If Loaded Successfully  --------------///
            if (state is AvailableBikesSuccessState)
              SizedBox(
                 height: 0.42.sh,
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
                        final bike = state.bikes[index]; // Use 'index' directly

                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.productViewRoute,
                              arguments: {"bikeFromAvailablePage": bike},
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Container(
                                width: 0.8.sw, // Adjust width as needed
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Stack(
                                    children: [
                                      ///-----------Price----------///
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: FadeInUp(
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20.sp,
                                                vertical: 8.sp),
                                            width: 0.9.sw,
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Text(
                                              "Price  ${bike.price} PKR",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15.sp,
                                                  fontWeight:
                                                      FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),

                                      ///-----------Picture----------///
                                      Positioned.fill(
                                        child: CachedNetworkImage(
                                          imageUrl: bike.picture,
                                          fit: BoxFit.cover,
                                          filterQuality:
                                              FilterQuality.high,
                                          placeholder: (context, url) =>
                                              Center(
                                                  child: CircularProgressIndicator()),
                                          errorWidget: (context, url,
                                                  error) =>
                                              Center(child: Icon(Icons.error)),
                                        ),
                                      ),

                                      ///-----------Company----------///
                                      Positioned(
                                        top: 0,
                                        left: 0,
                                        width: 0.4445.sw,
                                        child: FadeInLeft(
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15.sp,
                                                vertical: 6.sp),
                                            decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(0),
                                                border: Border.all()),
                                            child: Text(
                                              "${bike.company}",
                                              textAlign: TextAlign.center,
                                              overflow:
                                                  TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      ///-----------Engine----------///
                                      Positioned(
                                        top: 30.sp,
                                        left: 0,
                                        width: 0.4445.sw,
                                        child: FadeInDown(
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15.sp,
                                                vertical: 6.sp),
                                            decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(0),
                                                border: Border.all()),
                                            child: Text(
                                              "Engine ${bike.engineCc} CC",
                                              textAlign: TextAlign.center,
                                              overflow:
                                                  TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      ///-----------Model----------///
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        width: 0.45.sw,
                                        child: FadeInRight(
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15.sp,
                                                vertical: 6.sp),
                                            decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(0),
                                                border: Border.all()),
                                            child: Text(
                                              "Model ${bike.model}",
                                              textAlign: TextAlign.center,
                                              overflow:
                                                  TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      ///-----------Seats----------///
                                      Positioned(
                                        top: 30.sp,
                                        right: 0,
                                        width: 0.45.sw,
                                        child: FadeInDown(
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15.sp,
                                                vertical: 6.sp),
                                            decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(0),
                                                border: Border.all()),
                                            child: Text(
                                              "Seats Capacity ${bike.seats}",
                                              textAlign: TextAlign.center,
                                              overflow:
                                                  TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),

            ///-----------------  Dot Indicators ------------------///
            if (state is AvailableBikesSuccessState)
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
    );
  }

  void onPageChanged(int index) {
    context.read<AvailablePageViewChangedCubit>().changedPage(index);
  }
}
