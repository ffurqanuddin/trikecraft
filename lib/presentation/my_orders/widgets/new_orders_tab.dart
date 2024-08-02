import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trikecraft/logic/new_bike_order/new_bike_order_bloc.dart';
import 'package:trikecraft/logic/new_bike_order/new_bike_order_event.dart';
import 'package:trikecraft/logic/new_bike_order/new_bike_order_state.dart';
import 'package:trikecraft/presentation/my_orders/widgets/new_order_card_widget.dart';

class NewOrdersTab extends StatefulWidget {
  const NewOrdersTab({
    super.key,
  });

  @override
  State<NewOrdersTab> createState() => _NewOrdersTabState();
}

class _NewOrdersTabState extends State<NewOrdersTab> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<NewBikeOrderBloc>().add(LoadNewBikeOrderDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewBikeOrderBloc, NewBikeOrderState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is NewBikeOrderDataLoadedState) {
          return ListView.builder(
            itemCount: state.orders.length,
            itemBuilder: (context, index) =>
                NewOrderCardWidget(order: state.orders[index]),
          );
        } else if (state is NewBikeOrderDataLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is NewBikeOrderDataLoadingFailureState) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(state.errorMessage),
            ),
          );
        } else {
          return Center(
            child: Text("Something went wrong"),
          );
        }
      },
    );
  }
}
