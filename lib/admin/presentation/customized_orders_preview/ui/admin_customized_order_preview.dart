import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trikecraft/logic/customized_bike_order/customized_bike_order_bloc.dart';
import 'package:trikecraft/models/customization_order_model.dart';
import 'package:trikecraft/presentation/my_orders/widgets/customized_order_card_widget.dart';

import '../widgets/admin_customized_order_card_widget.dart';

class AdminCustomizedBikesOrderPreviewPage extends StatelessWidget {
  AdminCustomizedBikesOrderPreviewPage({super.key, required this.ordersList});

  List<CustomizationOrderModel> ordersList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customized Bikes Preview"),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: (ordersList.length > 0)
          ? ListView.builder(
              itemCount: ordersList.length,
              itemBuilder: (context, index) {
                CustomizationOrderModel order = ordersList[index];
                return AdminCustomizedOrderCardWidget(
                    order: order); // Use the custom widget
              },
            )
          : Center(
              child: Text("No orders found.", style: TextStyle(color: Colors.white),),
            ),
    );
  }
}
