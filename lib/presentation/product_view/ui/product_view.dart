import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:gap/gap.dart';
import 'package:injectable/injectable.dart';
import 'package:trikecraft/base/routes/app_routes.dart';

import '../../../base/assets/app_fonts.dart';
import '../../../logic/theme/theme_cubit.dart';
import '../../../models/bike_model.dart';

class ProductViewPage extends StatelessWidget {
  final BikeModel bike;

  const ProductViewPage({Key? key, required this.bike}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageSection(),
            Gap(20.h),
            _buildDetailsSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CachedNetworkImage(
          imageUrl: bike.picture,
          height: 300.h,
          fit: BoxFit.contain,
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error, size: 50),
        ),
      ),
    );
  }

  Widget _buildDetailsSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeInLeft(
            child: Text(
              "${bike.company} - ${bike.model}",
              style: TextStyle(
                fontSize: 26.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Gap(10.h),
          FadeInRight(
            child: Text(
              "Price: ${bike.price} PKR",
              style: TextStyle(
                fontSize: 22.sp,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Gap(20.h),
          _buildDetailRow("Engine:", "${bike.engineCc} CC"),
          _buildDetailRow("Seats:", bike.seats),
          _buildDetailRow("Color:", bike.color),
          _buildDetailRow("Transmission:", bike.transmission),
          _buildDetailRow("Gear:", bike.gear),
          _buildDetailRow("Brake:", bike.brake),
          _buildDetailRow("Self Start:", bike.selfStart ? "Yes" : "No"),
          _buildDetailRow("Roof:", bike.roof ? "Yes" : "No"),
          _buildDetailRow("Tyre Size:", bike.tyreSize),
          _buildDetailRow("Extra Details:", bike.extraDetail),
          Gap(20.h),
          FadeInUp(
            child: Text(
              "Available: ${bike.available ? "In Stock" : "Out of Stock"}",
              style: TextStyle(
                fontSize: 20.sp,
                color: bike.available ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          ///--------------- Swipe To Buy Now
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15.sp, horizontal: 10.sp),
            child: Center(
              child: SwipeButton.expand(
                thumb: Icon(Icons.double_arrow_rounded, color: Colors.white),
                child: Text(
                  "Swipe to Buy Now",
                  style: TextStyle(color: Colors.black),
                ),
                activeThumbColor: Theme.of(context).primaryColor,
                activeTrackColor: Colors.grey.shade300,
                onSwipe: () {
                  Navigator.pushNamed(
                      context, AppRoutes.p2pPaymentPageRoute,
                      arguments: bike);
                },
              ),
            ),
          ),
          Gap(20.sp),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return FadeInLeft(
      child: Padding(
        padding: EdgeInsets.only(bottom: 10.h),
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 18.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _buyNow(BuildContext context) {
    // Implement the buy now functionality here.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Buy Now button pressed"),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return IconButton(
            icon: Icon(CupertinoIcons.back,
                color: state.isDarkMode ? Colors.white : Colors.black),
            onPressed: () => Navigator.pop(context),
          );
        },
      ),
      title: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return FadeInDown(
            child: Text(
              "Product View",
              style: TextStyle(
                fontSize: 20.sp,
                fontFamily: AppFonts.poppins,
                color: state.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          );
        },
      ),
      centerTitle: true,
    );
  }
}
