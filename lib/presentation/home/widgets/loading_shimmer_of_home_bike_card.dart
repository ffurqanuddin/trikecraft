import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:trikecraft/presentation/home/widgets/shimmer_item.dart';

class LoadingShimmerOfHomeBikeCard extends StatelessWidget {
  const LoadingShimmerOfHomeBikeCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          height: 0.42.sh,
          child:ShimmerItem(),
        ),
      ),
    );
  }
}
