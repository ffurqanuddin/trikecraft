import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trikecraft/logic/customized_bike_order/customized_bike_order_bloc.dart';
import 'package:trikecraft/models/customization_order_model.dart';
import 'package:trikecraft/presentation/my_orders/widgets/customized_order_card_widget.dart';

class CustomizedBikesOrderTab extends StatelessWidget {
  const CustomizedBikesOrderTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomizedBikeOrderBloc, CustomizedBikeOrderState>(
      builder: (context, state) {
        if (state is CustomizedBikeOrderDataLoadingState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is CustomizedBikeOrderDataLoadedState) {
          if(state.orders.length>0){
          return ListView.builder(
            itemCount: state.orders.length,
            itemBuilder: (context, index) {
              CustomizationOrderModel order = state.orders[index];
              return CustomizedOrderCardWidget(
                  order: order); // Use the custom widget
            },
          );
          } else{
            return Center(child: Text("No orders found."));
          }
        } else if (state is CustomizedBikeOrderDataLoadingFailureState) {
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
