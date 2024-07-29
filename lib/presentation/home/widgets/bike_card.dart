import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trikecraft/presentation/home/widgets/available_widget.dart';
import 'package:trikecraft/presentation/home/widgets/info_box.dart';

class BikeCard extends StatelessWidget {
  final dynamic bike;

  const BikeCard({Key? key, required this.bike}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: 0.8.sw,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: FadeInUp(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 8.sp),
                    width: 0.9.sw,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Price  ${bike.price} PKR",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: CachedNetworkImage(
                  imageUrl: bike.picture,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                  placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                width: 0.4445.sw,
                child: FadeInLeft(
                  child: InfoBox(text: "${bike.company}"),
                ),
              ),
              Positioned(
                top: 30.sp,
                left: 0,
                width: 0.4445.sw,
                child: FadeInDown(
                  child: InfoBox(text: "Engine ${bike.engineCc} CC"),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                width: 0.45.sw,
                child: FadeInRight(
                  child: InfoBox(text: "Model ${bike.model}"),
                ),
              ),
              Positioned(
                top: 30.sp,
                right: 0,
                width: 0.45.sw,
                child: FadeInDown(
                  child: InfoBox(text: "Seats Capacity ${bike.seats}"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
