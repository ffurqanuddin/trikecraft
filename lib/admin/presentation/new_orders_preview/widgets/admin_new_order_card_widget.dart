import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:injectable/injectable.dart';
import 'package:trikecraft/admin/constant/order_status.dart';
import 'package:trikecraft/admin/logic/admin_bike_order/admin_bike_orders_cubit.dart';
import 'package:trikecraft/base/assets/app_fonts.dart';
import 'package:trikecraft/models/order_model.dart';
import 'package:trikecraft/presentation/my_orders/widgets/info_row.dart';
import 'package:trikecraft/utils/date_time_format.dart';
import 'package:trikecraft/utils/snackbars.dart';

class AdminNewBikeOrderCardWidget extends StatefulWidget {
  final NewBikeOrderModel order;

  const AdminNewBikeOrderCardWidget({super.key, required this.order});

  @override
  State<AdminNewBikeOrderCardWidget> createState() =>
      _AdminNewBikeOrderCardWidgetState();
}

class _AdminNewBikeOrderCardWidgetState
    extends State<AdminNewBikeOrderCardWidget> {
  final List<String> statusName = [
    AdminOrderStatus.pending,
    AdminOrderStatus.reviewing,
    AdminOrderStatus.approved,
    AdminOrderStatus.rejected,
    AdminOrderStatus.rfd,
    AdminOrderStatus.completed,
  ];

  late String orderStatus;
  late TextEditingController priceController;
  late TextEditingController extraDetailController;
  late TextEditingController senderAmountController;
  late TextEditingController transactionStatusController;

  @override
  void initState() {
    super.initState();
    orderStatus = widget.order.orderStatus;
    priceController = TextEditingController(text: widget.order.bike.price);
    extraDetailController =
        TextEditingController(text: widget.order.bike.extraDetail);
    senderAmountController =
        TextEditingController(text: widget.order.paymentDetails.amount);
    transactionStatusController = TextEditingController(
        text: widget.order.paymentDetails.transactionStatus);
  }

  @override
  void dispose() {
    priceController.dispose();
    extraDetailController.dispose();
    senderAmountController.dispose();
    transactionStatusController.dispose();
    super.dispose();
  }

  void _changeTransactionStatus(TextEditingController transactionStatus) {
    if (transactionStatus.text.isNotEmpty ||
        senderAmountController.text.isNotEmpty) {
      // Add functionality to change the payment transaction status
      context.read<AdminBikeOrdersCubit>().updateNewBikeOrder(
        orderId: widget.order.orderId,
        data: {
          "paymentDetails": {
            "transactionStatus": transactionStatus.text.trim(),
            'transactionId': widget.order.paymentDetails.transactionId,
            'senderName': widget.order.paymentDetails.senderName,
            'contactInfo': widget.order.paymentDetails.contactInfo,
            'paymentMethod': widget.order.paymentDetails.paymentMethod,
            'accountName': widget.order.paymentDetails.accountName,
            'amount': senderAmountController.text.trim(),
            'transactionDate': widget.order.paymentDetails.transactionDate,
          }
          // Example status
        },
      );
    }
  }

  void _changeExtraDetails(TextEditingController extraDetailController) {
    // Add functionality to change the payment transaction status
    context.read<AdminBikeOrdersCubit>().updateNewBikeOrder(
      orderId: widget.order.orderId,
      data: {
        "bike": {
          "extraDetail": extraDetailController.text.isNotEmpty
              ? extraDetailController.text.trim()
              : widget.order.bike.extraDetail,
          'tyreSize': widget.order.bike.tyreSize,
          'engineCc': widget.order.bike.engineCc,
          'roof': widget.order.bike.roof,
          'color': widget.order.bike.color,
          'bikeId': widget.order.bike.bikeId,
          'available': widget.order.bike.available,
          'picture': widget.order.bike.picture,
          'seats': widget.order.bike.seats,
          'brake': widget.order.bike.brake,
          'transmission': widget.order.bike.transmission,
          'kick': widget.order.bike.kick,
          'price': priceController.text.isNotEmpty
              ? priceController.text.trim()
              : widget.order.bike.price,
          'model': widget.order.bike.model,
          'selfStart': widget.order.bike.selfStart,
          'gear': widget.order.bike.gear,
          'company': widget.order.bike.company,
        }
        // Example status
      },
    );
  }

  void _changeOrderStatus(String orderStatus) {
    if (orderStatus.isNotEmpty) {
      context.read<AdminBikeOrdersCubit>().updateNewBikeOrder(
        orderId: widget.order.orderId,
        data: {
          "orderStatus": orderStatus,
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AdminBikeOrdersCubit, AdminBikeOrderState>(
      listener: (context, state) {
        if (state is AdminOrderDataIsSuccessfullyUpdatedState) {
          MySnackbars.showSimpleSnackbar(context,
              message: "Order has been updated");
        }
        if (state is AdminFailureState) {
          Fluttertoast.showToast(
              msg: state.errorMessage, backgroundColor: Colors.red);
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
                    "Order No. ${widget.order.orderId}",
                    style: TextStyle(
                      fontFamily: AppFonts.poppins,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                  subtitle: Text(
                    "Order Date: ${widget.order.orderDate.toLocal().toString().split(' ')[0]}",
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
                          color: _getStatusColor(widget.order.orderStatus),
                        ),
                        child: Text(
                          widget.order.orderStatus,
                          style:
                              TextStyle(color: Colors.white, fontSize: 13.sp),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
                ExpansionTile(
                  initiallyExpanded: false,
                  title: Text("Show More"),
                  children: [
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
                              fontFamily: AppFonts.poppins,
                            ),
                          ),
                          InfoRow(title: "User", value: widget.order.userName),
                          InfoRow(
                              title: "Email", value: widget.order.userEmail),
                          InfoRow(
                              title: "Contact",
                              value: widget.order.paymentDetails.contactInfo),
                          SizedBox(height: 10),
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
                              value:
                                  widget.order.bike.selfStart ? "Yes" : "No"),
                          InfoRow(
                              title: "Roof",
                              value: widget.order.bike.roof ? "Yes" : "No"),
                          InfoRow(
                              title: "Color", value: widget.order.bike.color),
                          InfoRow(
                              title: "Seats", value: widget.order.bike.seats),
                          InfoRow(
                              title: "Engine CC",
                              value: widget.order.bike.engineCc),
                          InfoRow(
                              title: "Brake", value: widget.order.bike.brake),
                          InfoRow(title: "Gear", value: widget.order.bike.gear),
                          InfoRow(
                              title: "Tyre Size",
                              value: widget.order.bike.tyreSize),
                          InfoRow(
                              title: "Transmission",
                              value: widget.order.bike.transmission),
                          InfoRow(
                              title: "Bike Price",
                              value: widget.order.bike.price),
                          Gap(10),
                          Text(
                            "Payment Details",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                              fontFamily: AppFonts.poppins,
                            ),
                          ),
                          InfoRow(
                              title: "Transaction Id",
                              value: widget.order.paymentDetails.transactionId),
                          InfoRow(
                              title: "Transaction Date",
                              value: MyDateTimeFormatter.fTD(
                                  widget.order.paymentDetails.transactionDate)),
                          InfoRow(
                              title: "Account Name",
                              value: widget.order.paymentDetails.accountName),
                          InfoRow(
                              title: "Bank Name / PM",
                              value: widget.order.paymentDetails.paymentMethod),
                          InfoRow(
                              title: "Sender Name",
                              value: widget.order.paymentDetails.senderName),
                          InfoRow(
                              title: "Send Amount",
                              value: widget.order.paymentDetails.amount),
                          InfoRow(
                              title: "Contact Info",
                              value: widget.order.paymentDetails.contactInfo),
                          Gap(10),
                          Text(
                            "Change Price",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                            ),
                          ),
                          Gap(10),
                          TextField(
                            controller: priceController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "Price",
                              border: OutlineInputBorder(),
                            ),
                          ),
                          Gap(10),
                          Gap(10),
                          Text(
                            "Received Amount",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                            ),
                          ),
                          Gap(10),
                          TextField(
                            controller: senderAmountController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "Received by sender",
                              border: OutlineInputBorder(),
                            ),
                          ),
                          Gap(10),
                          Text(
                            "Additional Details",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                            ),
                          ),
                          Gap(10),
                          TextField(
                            controller: extraDetailController,
                            decoration: InputDecoration(
                              labelText: "Extra Details",
                              border: OutlineInputBorder(),
                            ),
                          ),
                          Gap(10),
                          Text(
                            "Transaction Status",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                            ),
                          ),
                          Gap(10),
                          TextField(
                            controller: transactionStatusController,
                            decoration: InputDecoration(
                              labelText: "Payment Status",
                              border: OutlineInputBorder(),
                            ),
                          ),
                          Gap(20),
                          if (widget.order.orderStatus.toLowerCase() ==
                              AdminOrderStatus.pending.toLowerCase())
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.sp),
                              child: SwipeButton.expand(
                                thumb: Icon(Icons.double_arrow_rounded,
                                    color: Colors.white),
                                child: Text("Change Status to Reviewing"),
                                activeThumbColor:
                                    Theme.of(context).primaryColor,
                                activeTrackColor:
                                    const Color.fromARGB(255, 0, 0, 0),
                                onSwipe: () {
                                  context
                                      .read<AdminBikeOrdersCubit>()
                                      .updateNewBikeOrder(
                                    orderId: widget.order.orderId,
                                    data: {
                                      "orderStatus": AdminOrderStatus.reviewing,
                                    },
                                  );
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          if (widget.order.orderStatus.toLowerCase() !=
                                  AdminOrderStatus.pending.toLowerCase() &&
                              widget.order.orderStatus.toLowerCase() !=
                                  AdminOrderStatus.completed.toLowerCase())
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Change Order Status",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontFamily: AppFonts.poppins),
                              ),
                            ),
                          if (widget.order.orderStatus.toLowerCase() !=
                                  AdminOrderStatus.pending.toLowerCase() &&
                              widget.order.orderStatus.toLowerCase() !=
                                  AdminOrderStatus.completed.toLowerCase())
                            _buildExpansionTile(
                              context: context,
                              title: "Order Status",
                              options: statusName,
                              selectedOption: orderStatus,
                              onChanged: (value) {
                                setState(() {
                                  orderStatus = value.toString();
                                });
                              },
                            ),
                          if (widget.order.orderStatus.toLowerCase() !=
                              AdminOrderStatus.pending)
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.sp),
                              child: SwipeButton.expand(
                                thumb: Icon(Icons.double_arrow_rounded,
                                    color: Colors.white),
                                child: Text("Update Order"),
                                activeThumbColor:
                                    Theme.of(context).primaryColor,
                                activeTrackColor:
                                    const Color.fromARGB(255, 0, 0, 0),
                                onSwipe: () {
                                  _changeTransactionStatus(
                                      transactionStatusController);
                                  _changeExtraDetails(extraDetailController);
                                  _changeOrderStatus(orderStatus);
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'reviewing':
        return Colors.blue;
      case 'approved':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      case 'rfd':
        return Colors.purple;
      case 'completed':
        return Colors.grey;
      default:
        return Colors.black;
    }
  }

  Widget _buildExpansionTile({
    required BuildContext context,
    required String title,
    required List<String> options,
    required String selectedOption,
    required void Function(String?) onChanged,
  }) {
    return ExpansionTile(
      title: Text(title),
      children: [
        Column(
          children: [
            for (var option in options)
              ListTile(
                title: Text(option),
                leading: Radio<String>(
                  value: option,
                  groupValue: selectedOption,
                  onChanged: onChanged,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
