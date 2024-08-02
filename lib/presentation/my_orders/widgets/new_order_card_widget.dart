import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:trikecraft/base/assets/app_fonts.dart';
import 'package:trikecraft/models/order_model.dart';
import '../../../logic/new_bike_order/new_bike_order_bloc.dart';
import '../../../logic/new_bike_order/new_bike_order_state.dart';
import 'info_row.dart';

class NewOrderCardWidget extends StatelessWidget {
  final NewBikeOrderModel order;

  const NewOrderCardWidget({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return BlocListener<NewBikeOrderBloc, NewBikeOrderState>(
      listener: (context, state) {},
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
                      fontSize: 16.sp,
                    ),
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
                              fontFamily: AppFonts.poppins,
                            ),
                          ),
                          InfoRow(title: "User", value: order.userName),
                          InfoRow(title: "Email", value: order.userEmail),
                          SizedBox(height: 10),

                          ///---------------- Bike Details -------------------///
                          _buildGlassContainer(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Bike Details",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.sp,
                                    fontFamily: AppFonts.poppins,
                                  ),
                                ),
                                InfoRow(
                                    title: "Self Start",
                                    value: order.bike.selfStart ? "Yes" : "No"),
                                InfoRow(
                                    title: "Roof",
                                    value: order.bike.roof ? "Yes" : "No"),
                                InfoRow(title: "Color", value: order.bike.color),
                                InfoRow(
                                    title: "Seats",
                                    value: order.bike.seats.toString()),
                                InfoRow(
                                    title: "Engine CC",
                                    value: order.bike.engineCc),
                                InfoRow(title: "Brake", value: order.bike.brake),
                                InfoRow(title: "Gear", value: order.bike.gear),
                                InfoRow(
                                    title: "Tyre Size",
                                    value: order.bike.tyreSize),
                                InfoRow(
                                    title: "Transmission",
                                    value: order.bike.transmission),
                              ],
                            ),
                          ),
                          Gap(10),

                          ///---------------- Payment Details -------------------///
                          _buildGlassContainer(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Payment Details",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17.sp,
                                    fontFamily: AppFonts.poppins,
                                  ),
                                ),
                                Gap(10),
                                InfoRow(
                                    title: "Transaction ID",
                                    value: order.paymentDetails.transactionId),
                                InfoRow(
                                    title: "Sender Name",
                                    value: order.paymentDetails.senderName),
                                InfoRow(
                                    title: "Contact Info",
                                    value: order.paymentDetails.contactInfo),
                                InfoRow(
                                    title: "Payment Method",
                                    value: order.paymentDetails.paymentMethod),
                                InfoRow(
                                    title: "Account Name",
                                    value: order.paymentDetails.accountName),
                                InfoRow(
                                    title: "Received Amount",
                                    value: order.paymentDetails.amount
                                        .toString()),
                                InfoRow(
                                    title: "Transaction Status",
                                    value: order.paymentDetails.transactionStatus),
                              ],
                            ),
                          ),
                          Gap(20),

                          ///---------------- Total Price  -------------------///
                          Text(
                            "Total Price : ${order.bike.price}",
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Gap(10),
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

  Widget _buildGlassContainer({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: child,
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "reviewing":
      case "review":
      case "checking":
        return Colors.red;
      case "approved":
      case "submitted":
        return Colors.green;
      case "completed":
      case "complete":
      case "done":
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}
