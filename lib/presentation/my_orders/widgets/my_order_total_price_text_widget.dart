import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trikecraft/base/assets/app_fonts.dart';
import 'package:trikecraft/models/customization_order_model.dart';

class MyOrderTotalPriceTextWidget extends StatelessWidget {
  const MyOrderTotalPriceTextWidget({
    super.key,
    required this.order,
  });

  final CustomizationOrderModel order;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Total Price",
            style: TextStyle(
                fontFamily: AppFonts.poppins,
                fontWeight: FontWeight.bold,
                fontSize: 17.sp,
                color: Theme.of(context).primaryColor)),
        Text(
          '${order.totalPrice} PKR',
          style: TextStyle(
              fontFamily: AppFonts.poppins,
              fontWeight: FontWeight.bold,
              fontSize: 17.sp,
              color: Theme.of(context).primaryColor),
        ),
      ],
    );
  }
}
