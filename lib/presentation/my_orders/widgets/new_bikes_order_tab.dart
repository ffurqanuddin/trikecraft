import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/new_bike_order/new_bike_order_bloc.dart';
import '../../../logic/new_bike_order/new_bike_order_state.dart';
import '../../../models/order_model.dart';
import 'new_order_card_widget.dart';

class NewBikesOrderTab extends StatelessWidget {
  const NewBikesOrderTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewBikeOrderBloc, NewBikeOrderState>(
      builder: (context, state) {
        if (state is NewBikeOrderDataLoadingState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is NewBikeOrderDataLoadedState) {
          if (state.orders.length > 0) {
            return ListView.builder(
              itemCount: state.orders.length,
              itemBuilder: (context, index) {
                NewBikeOrderModel order = state.orders[index];
                return NewOrderCardWidget(
                    order: order); // Use the custom widget
              },
            );
          } else {
            return Center(child: Text("No orders found."));
          }
        } else if (state is NewBikeOrderDataLoadingFailureState) {
          return Center(
            child: Text(
              'Failed to load orders: ${state.errorMessage}',
              style: TextStyle(color: Colors.red),
            ),
          );
        } else {
          return Center(child: Text("No orders found."));
        }
      },
    );
  }
}
