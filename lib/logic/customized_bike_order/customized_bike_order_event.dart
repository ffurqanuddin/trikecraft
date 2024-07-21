part of 'customized_bike_order_bloc.dart';

sealed class CustomizedBikeOrderEvent extends Equatable {
  const CustomizedBikeOrderEvent();

  @override
  List<Object> get props => [];
}

class SaveCustomizedBikeOrderDataEvent extends CustomizedBikeOrderEvent {
  final CustomizationOrderModel customizationOrderModel;

  const SaveCustomizedBikeOrderDataEvent({required this.customizationOrderModel});

  @override
  List<Object> get props => [customizationOrderModel];
}

class LoadCustomizedBikeOrderDataEvent extends CustomizedBikeOrderEvent {
  const LoadCustomizedBikeOrderDataEvent();

  @override
  List<Object> get props => [];
}


class CancelCustomizedBikeOrderDataEvent extends CustomizedBikeOrderEvent {
  const CancelCustomizedBikeOrderDataEvent({required this.orderId});
   final String orderId;
  @override
  List<Object> get props => [orderId];
}

