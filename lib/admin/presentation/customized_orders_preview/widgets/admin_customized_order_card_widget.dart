
import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:gap/gap.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:trikecraft/admin/constant/order_status.dart';
import 'package:trikecraft/admin/logic/admin_customizable_order/admin_customizable_orders_cubit.dart';
import 'package:trikecraft/base/assets/app_fonts.dart';
import 'package:trikecraft/logic/customized_bike_order/customized_bike_order_bloc.dart';
import 'package:trikecraft/models/customization_order_model.dart';
import 'package:trikecraft/presentation/my_orders/widgets/info_row.dart';
import 'package:trikecraft/presentation/my_orders/widgets/my_order_total_price_text_widget.dart';
import 'package:trikecraft/utils/snackbars.dart';

class AdminCustomizedOrderCardWidget extends StatefulWidget {
  final CustomizationOrderModel order;

  const AdminCustomizedOrderCardWidget({super.key, required this.order});

  @override
  State<AdminCustomizedOrderCardWidget> createState() =>
      _AdminCustomizedOrderCardWidgetState();
}

class _AdminCustomizedOrderCardWidgetState
    extends State<AdminCustomizedOrderCardWidget> {
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    orderStatus = "";
    priceController = TextEditingController(text: "");
    extraDetailController = TextEditingController(text: "");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    priceController.dispose();
    extraDetailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AdminCustomizableOrdersCubit,
        AdminCustomizableOrderState>(
      listener: (context, state) {
        if (state is AdminOrderDataIsSuccessfullyUpdatedState) {
          MySnackbars.showSimpleSnackbar(context,
              message: "Order Status is updated");
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
                    "Order No. ${widget.order.orderId}",
                    style: TextStyle(
                        fontFamily: AppFonts.poppins,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp),
                  ),

                  ///------------- Order Date -------------///
                  subtitle: Text(
                    "Order Date: ${widget.order.orderDate.toLocal().toString().split(' ')[0]}",
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
                          color: _getStatusColor(widget.order.orderStatus),
                        ),
                        child: Text(
                          widget.order.orderStatus,
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

                          InfoRow(title: "User", value: widget.order.userName),
                          InfoRow(
                              title: "Email", value: widget.order.userEmail),
                          InfoRow(
                              title: "Contact",
                              value: widget.order.contactInfo),
                          InfoRow(
                              title: "Address", value: widget.order.address),
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
                              value: widget.order.selfStart ? "Yes" : "No"),
                          InfoRow(
                              title: "Roof",
                              value: widget.order.roof ? "Yes" : "No"),
                          InfoRow(title: "Color", value: widget.order.color),
                          InfoRow(
                              title: "Seats",
                              value: widget.order.seats.toString()),
                          InfoRow(
                              title: "Engine CC", value: widget.order.engineCc),
                          InfoRow(title: "Brake", value: widget.order.brake),
                          InfoRow(title: "Gear", value: widget.order.gear),
                          InfoRow(
                              title: "Tyre Size", value: widget.order.tyreSize),
                          InfoRow(
                              title: "Transmission",
                              value: widget.order.transmission),
                          Gap(10),

                          ///---------------- Total Price  -------------------///
                          MyOrderTotalPriceTextWidget(order: widget.order),
                          Gap(10.sp),

                          ///---------------- Additional Information  -------------------///
                          Text(
                            "Additional Details",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15.sp),
                          ),
                          Text(
                              widget.order.extraDetail.isEmpty
                                  ? "None"
                                  : widget.order.extraDetail,
                              style: TextStyle(fontSize: 14.sp)),
                          Gap(20.sp),
                          if (widget.order.orderStatus ==
                              AdminOrderStatus.pending)
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.sp),
                              child: SwipeButton.expand(
                                thumb: Icon(Icons.double_arrow_rounded,
                                    color: Colors.white),
                                child: Text("     Change Status to Reviewing"),
                                activeThumbColor:
                                    Theme.of(context).primaryColor,
                                activeTrackColor:
                                    const Color.fromARGB(255, 0, 0, 0),
                                onSwipe: () {
                                  context
                                      .read<AdminCustomizableOrdersCubit>()
                                      .updateCustomizedBikeOrder(
                                          orderId: widget.order.orderId,
                                          data: {
                                        "orderStatus":
                                            AdminOrderStatus.reviewing
                                      });
                                  Navigator.pop(context);
                                },
                              ),
                            ),

                          if (widget.order.orderStatus !=
                              AdminOrderStatus.pending && widget.order.orderStatus !=
                              AdminOrderStatus.completed)
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

                          //---------Order Status ---------------//
                          if (widget.order.orderStatus !=
                              AdminOrderStatus.pending && widget.order.orderStatus !=
                              AdminOrderStatus.completed)
                            _buildExpansionTile(
                              context: context,
                              title: "Order Status",
                              options: statusName,
                              selectedOption: orderStatus.isEmpty
                                  ? widget.order.orderStatus
                                  : orderStatus,
                              onSelect: (value) =>
                                  setState(() => orderStatus = value),
                            ),
                          Gap(10),

                          ///--------Change Order Total Price ------///
                          if (widget.order.orderStatus !=
                              AdminOrderStatus.pending && widget.order.orderStatus !=
                              AdminOrderStatus.completed)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Change Order Total Price",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontFamily: AppFonts.poppins),
                              ),
                            ),
                          Gap(5),
                          if (widget.order.orderStatus !=
                              AdminOrderStatus.pending && widget.order.orderStatus !=
                              AdminOrderStatus.completed)
                            TextField(
                              controller: priceController,
                              keyboardType: TextInputType.number,
                              maxLines: 1,
                              onTapOutside: (p) {
                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                              decoration: InputDecoration(
                                hintText: "Write a new price here",
                              ),
                            ),
                          Gap(10),

                          ///--------Update Order Additional Details ------///
                          if (widget.order.orderStatus !=
                              AdminOrderStatus.pending && widget.order.orderStatus !=
                              AdminOrderStatus.completed)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Change Order Additional Details",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontFamily: AppFonts.poppins),
                              ),
                            ),
                          Gap(5),
                          if (widget.order.orderStatus !=
                              AdminOrderStatus.pending && widget.order.orderStatus !=
                              AdminOrderStatus.completed)
                            TextField(
                              controller: extraDetailController,
                              maxLines: 6,
                              onTapOutside: (p) {
                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                              decoration: InputDecoration(
                                hintText: "Write extra detail of changes",
                              ),
                            ),
                          Gap(10),
                          if (widget.order.orderStatus !=
                              AdminOrderStatus.pending && widget.order.orderStatus !=
                              AdminOrderStatus.completed)
                            Center(
                              child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                      fixedSize: Size(1.sw, 0.05.sh)),
                                  onPressed: () {
                                    _updateButtonOnTap(context);
                                  },
                                  label: Text("Update Data")),
                            ),
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

  ///-----------------  Methods ----------------////
  void _updateButtonOnTap(BuildContext context) {
    if (orderStatus.isNotEmpty) {
      context.read<AdminCustomizableOrdersCubit>().updateCustomizedBikeOrder(
          orderId: widget.order.orderId, data: {"orderStatus": orderStatus});
    }
    if (priceController.text.isNotEmpty) {
      context.read<AdminCustomizableOrdersCubit>().updateCustomizedBikeOrder(
          orderId: widget.order.orderId,
          data: {"totalPrice": priceController.text});
    }
    if(extraDetailController.text.isNotEmpty){
      context.read<AdminCustomizableOrdersCubit>().updateCustomizedBikeOrder(
          orderId: widget.order.orderId,
          data: {"extraDetail": extraDetailController.text});
    }
    Navigator.pop(context);
  }

  /// Builds an expansion tile with filter chips for selection
  Widget _buildExpansionTile({
    required BuildContext context,
    required String title,
    required List<String> options,
    required String selectedOption,
    required ValueChanged<String> onSelect,
  }) {
    return FadeInUp(
      child: ExpansionTile(
        initiallyExpanded: false,
        title: Text(title),
        children: [
          Wrap(
            spacing: 8.sp,
            children: options.map((option) {
              return FilterChip(
                label: Text(option),
                selected: option == selectedOption,
                onSelected: (val) => onSelect(option),
                selectedColor: Theme.of(context).primaryColor,
                backgroundColor: Colors.grey.shade200,
                shape: StadiumBorder(
                    side: BorderSide(color: Colors.grey.shade400)),
                labelStyle: TextStyle(
                  color: option == selectedOption ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              );
            }).toList(),
          ),
        ],
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
