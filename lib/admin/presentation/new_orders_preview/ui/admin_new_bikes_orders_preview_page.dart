
import 'package:flutter/material.dart';
import 'package:trikecraft/models/order_model.dart';

import '../widgets/admin_new_order_card_widget.dart';


class AdminNewBikesOrderPreviewPage extends StatelessWidget {
  AdminNewBikesOrderPreviewPage({super.key, required this.ordersList});

  final List<NewBikeOrderModel> ordersList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Bikes Preview"),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body:  (ordersList.length > 0)
          ? ListView.builder(
              itemCount: ordersList.length,
              itemBuilder: (context, index) {
                NewBikeOrderModel order = ordersList[index];
                return AdminNewBikeOrderCardWidget(
                    order: order); // Use the custom widget
              },
            )
          : Center(
              child: Text("No orders found.", style: TextStyle(color: Colors.white),),
            ),
    );
  }
}
