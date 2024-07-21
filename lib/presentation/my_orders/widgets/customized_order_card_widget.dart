import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:trikecraft/base/assets/app_fonts.dart';
import 'package:trikecraft/logic/customized_bike_order/customized_bike_order_bloc.dart';
import 'package:trikecraft/models/customization_order_model.dart';
import 'package:trikecraft/presentation/my_orders/widgets/info_row.dart';

class CustomizedOrderCardWidget extends StatelessWidget {
  final CustomizationOrderModel order;

  const CustomizedOrderCardWidget({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CustomizedBikeOrderBloc, CustomizedBikeOrderState>(
      listener: (context, state) {
       if(state is CustomizedBikeOrderDataCancelFailureState){
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
                ListTile(
                  title: Text(
                    "Order No. ${order.orderId}",
                    style: TextStyle(
                        fontFamily: AppFonts.poppins,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp),
                  ),
                  subtitle: Text(
                    "Order Date: ${order.orderDate.toLocal().toString().split(' ')[0]}",
                    style: TextStyle(fontSize: 14.sp),
                  ),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      InfoRow(title: "Roof", value: order.roof ? "Yes" : "No"),
                      InfoRow(title: "Color", value: order.color),
                      InfoRow(title: "Seats", value: order.seats.toString()),
                      InfoRow(title: "Engine CC", value: order.engineCc),
                      InfoRow(title: "Brake", value: order.brake),
                      InfoRow(title: "Gear", value: order.gear),
                      InfoRow(title: "Transmission", value: order.transmission),
                      InfoRow(
                          title: "Total Price",
                          value: "${order.totalPrice} PKR"),
                      SizedBox(height: 10),
                      Text(
                        "Additional Details",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15.sp),
                      ),
                      Text(order.extraDetail,
                          style: TextStyle(fontSize: 14.sp)),
                      SizedBox(height: 10),
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
                                    context.read<CustomizedBikeOrderBloc>().add(
                                        CancelCustomizedBikeOrderDataEvent(
                                            orderId: order.orderId));
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
            ),
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Reviewing":
        return Colors.red;
      case "Approved":
        return Colors.green;
      case "Completed":
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}
