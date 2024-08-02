import 'package:equatable/equatable.dart';
import 'package:trikecraft/models/order_model.dart';

sealed class NewBikeOrderEvent extends Equatable {
  const NewBikeOrderEvent();

  @override
  List<Object> get props => [];
}

class SaveNewBikeOrderDataEvent extends NewBikeOrderEvent {
  final NewBikeOrderModel newOrderModel;

  const SaveNewBikeOrderDataEvent({required this.newOrderModel});

  // @override
  List<Object> get props => [newOrderModel];
}

class LoadNewBikeOrderDataEvent extends NewBikeOrderEvent {
  const LoadNewBikeOrderDataEvent();

  @override
  List<Object> get props => [];
}
