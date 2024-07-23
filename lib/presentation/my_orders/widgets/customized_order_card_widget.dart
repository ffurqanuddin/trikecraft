import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:gap/gap.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:trikecraft/base/assets/app_fonts.dart';
import 'package:trikecraft/logic/customized_bike_order/customized_bike_order_bloc.dart';
import 'package:trikecraft/models/customization_order_model.dart';
import 'package:trikecraft/presentation/my_orders/widgets/info_row.dart';
import 'package:trikecraft/presentation/my_orders/widgets/my_order_total_price_text_widget.dart';

class CustomizedOrderCardWidget extends StatelessWidget {
  final CustomizationOrderModel order;

  const CustomizedOrderCardWidget({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CustomizedBikeOrderBloc, CustomizedBikeOrderState>(
      listener: (context, state) {
        if (state is CustomizedBikeOrderDataCancelFailureState) {
          showTopSnackBar(OverlayState(), Text(state.errorMessage));
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///------------- Order No. -------------///
                ListTile(
                  title: Text(
                    "Order No. ${order.orderId}",
                    style: TextStyle(
                        fontFamily: AppFonts.poppins,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp),
                  ),

                  ///------------- Order Date -------------///
                  subtitle: Text(
                    "Order Date: ${order.orderDate.toLocal().toString().split(' ')[0]}",
                    style: TextStyle(fontSize: 14.sp),
                  ),

                  ///------------- Order Status -------------///
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Status",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 12.sp),
                      ),
                      Container(
                        padding: EdgeInsets.all(6.sp),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: _getStatusColor(order.orderStatus),
                        ),
                        child: Text(
                          order.orderStatus,
                          style:
                              TextStyle(color: Colors.white, fontSize: 13.sp),
                        ),
                      )
                    ],
                  ),
                ),
                Divider(),

                ///--------------- SHOW MORE -------------------////
                ExpansionTile(
                  initiallyExpanded: false,
                  title: Text("Show More"),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ///---------------- User Information  -------------------///
                          Text(
                            "User Information",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                                fontFamily: AppFonts.poppins),
                          ),

                          InfoRow(title: "User", value: order.userName),
                          InfoRow(title: "Email", value: order.userEmail),
                          InfoRow(title: "Contact", value: order.contactInfo),
                          InfoRow(title: "Address", value: order.address),
                          SizedBox(height: 10),
                          Text(
                            "Bike Details",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                                fontFamily: AppFonts.poppins),
                          ),
                          InfoRow(
                              title: "Self Start",
                              value: order.selfStart ? "Yes" : "No"),
                          InfoRow(
                              title: "Roof", value: order.roof ? "Yes" : "No"),
                          InfoRow(title: "Color", value: order.color),
                          InfoRow(
                              title: "Seats", value: order.seats.toString()),
                          InfoRow(title: "Engine CC", value: order.engineCc),
                          InfoRow(title: "Brake", value: order.brake),
                          InfoRow(title: "Gear", value: order.gear),
                          InfoRow(title: "Tyre Size", value: order.tyreSize),
                          InfoRow(
                              title: "Transmission", value: order.transmission),
                          Gap(10),

                          ///---------------- Total Price  -------------------///
                          MyOrderTotalPriceTextWidget(order: order),
                          Gap(10.sp),

                          ///---------------- Additional Information  -------------------///
                          Text(
                            "Additional Details",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15.sp),
                          ),
                          Text(
                              order.extraDetail.isEmpty
                                  ? "None"
                                  : order.extraDetail,
                              style: TextStyle(fontSize: 14.sp)),
                          Gap(20.sp),
                          if (order.orderStatus == "pending")
                            BlocBuilder<CustomizedBikeOrderBloc,
                                CustomizedBikeOrderState>(
                              builder: (context, state) {
                                if (state
                                    is CustomizedBikeOrderDataCancelLoadingState) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else {
                                  return Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.sp),
                                    child: SwipeButton.expand(
                                      thumb: Icon(Icons.double_arrow_rounded,
                                          color: Colors.white),
                                      child: Text("Swipe to Cancel Order"),
                                      activeThumbColor:
                                          Theme.of(context).primaryColor,
                                      activeTrackColor: Colors.grey.shade300,
                                      onSwipe: () {
                                        print("Order is Canceled");
                                        context
                                            .read<CustomizedBikeOrderBloc>()
                                            .add(
                                                CancelCustomizedBikeOrderDataEvent(
                                                    orderId: order.orderId));
                                        context.read<CustomizedBikeOrderBloc>().add(
                                            LoadCustomizedBikeOrderDataEvent()); //Again Load Bike Data After Cancel the order
                                      },
                                    ),
                                  );
                                }
                              },
                            )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Reviewing" || "review" || "reviewing" || "checking":
        return Colors.red;
      case "Approved" || "approved" || "submitted":
        return Colors.green;
      case "Completed" || "complete" || "completed" || "done":
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}
