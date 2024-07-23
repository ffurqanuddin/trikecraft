import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trikecraft/base/assets/app_fonts.dart';
import 'package:trikecraft/logic/customized_bike_order/customized_bike_order_bloc.dart';
import 'package:trikecraft/presentation/my_orders/widgets/customized_bikes_order_tab.dart';
import 'package:trikecraft/presentation/my_orders/widgets/new_orders_tab.dart';
import 'package:trikecraft/presentation/my_orders/widgets/whats_app_now_floating_action_button_widget.dart';

class MyOrdersPage extends StatelessWidget {
  const MyOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Load orders when the page is built
    context
        .read<CustomizedBikeOrderBloc>()
        .add(LoadCustomizedBikeOrderDataEvent());

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            "My Orders",
            style: TextStyle(fontFamily: AppFonts.poppins),
          ),
          
          
          bottom: TabBar(
            tabs: [
              Tab(text: "New Orders"),
              Tab(text: "Customized Bikes Orders"),
            ],
          ),
        ),

        floatingActionButton: WhatsAppNowButtonWidget(),
        body: TabBarView(
          children: [
            // New Orders Tab
            NewOrdersTab(),
            // Customized Bikes Orders Tab
            CustomizedBikesOrderTab(),
          ],
        ),
      ),
    );
  }
}
