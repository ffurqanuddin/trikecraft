import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:trikecraft/base/assets/app_fonts.dart';

import '../../../logic/available_bikes/available_bikes_bloc.dart';

class AvailableWidget extends StatefulWidget {
  AvailableWidget({super.key});

  @override
  State<AvailableWidget> createState() => _AvailableWidgetState();
}

class _AvailableWidgetState extends State<AvailableWidget> {
  late PageController _pageViewController;
  late int _pageIndex;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageIndex = 0;
    _pageViewController = PageController(initialPage: _pageIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<AvailableBikesBloc, AvailableBikesState>(
        builder: (context, state) {
          return Column(
            children: [
              Gap(0.02.sh),
              Text(
                "Available",
                style: TextStyle(
                    fontSize: 23,
                    fontFamily: AppFonts.poppins,
                    fontWeight: FontWeight.w500),
              ),

              Gap(0.01.sh),
              //---
              if (state is AvailableBikesLoadingState)
                CircularProgressIndicator(),

              if (state is AvailableBikesSuccessState)
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      // color: Colors.amber,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: PageView.builder(
                      scrollDirection: Axis.horizontal,
                      controller: _pageViewController,
                      physics: BouncingScrollPhysics(),
                      itemCount: state.bikesList.length,
                      onPageChanged: onPageChanged,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 0.25.sh,
                          width: 0.9.sw,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                  state.bikesList[state.pageIndex].picture,
                                ),
                                fit: BoxFit.contain),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Stack(
                            children: [
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: FadeInLeft(
                                    child: Container(
                                        padding: EdgeInsets.all(2),
                                        margin:
                                            EdgeInsets.only(top: 20, left: 10),
                                        decoration: BoxDecoration(
                                          color:
                                              Color.fromARGB(255, 238, 0, 255),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          " ${state.bikesList[state.pageIndex].comapanyName} ",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  )),
                              Align(
                                  alignment: Alignment.topRight,
                                  child: FadeInRight(
                                    child: Container(
                                        padding: EdgeInsets.all(6),
                                        margin:
                                            EdgeInsets.only(top: 20, right: 10),
                                        decoration: BoxDecoration(
                                          color:
                                              Color.fromARGB(255, 255, 213, 0),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          "Model ${state.bikesList[state.pageIndex].model} ",
                                          style: TextStyle(
                                              color: const Color.fromARGB(
                                                  255, 0, 0, 0),
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  )),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: FadeInRight(
                                  child: Container(
                                      padding: EdgeInsets.all(2),
                                      margin: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        "Price ${state.bikesList[state.pageIndex].price}\$ ",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontFamily: AppFonts.poppins),
                                      )),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

              BlocBuilder<AvailableBikesBloc, AvailableBikesState>(
                  builder: (context, state) {
                if (state is AvailableBikesSuccessState) {
                  return Padding(
                    padding: EdgeInsets.all(10.sp),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SmoothPageIndicator(
                        controller: _pageViewController,
                        count: state.bikesList.length,
                        axisDirection: Axis.horizontal,
                        onDotClicked: onDotClicked,
                        effect: ExpandingDotsEffect(
                            activeDotColor: Theme.of(context).primaryColor),
                      ),
                    ),
                  );
                }
                return Text("");
              }),
            ],
          );
        },
      ),
    );
  }

  void onPageChanged(int index) {
    context.read<AvailableBikesBloc>().add(AvailableBikesPageChangeEvent(
          pageIndex: index,
          controller: _pageViewController,
        ));
  }

  void onDotClicked(int index) {
    context.read<AvailableBikesBloc>().add(AvailableBikesPageChangeEvent(
          pageIndex: index,
          controller: _pageViewController,
        ));
  }
}
