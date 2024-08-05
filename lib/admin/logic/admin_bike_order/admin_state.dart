part of 'admin_bike_orders_cubit.dart';

abstract class AdminBikeOrderState extends Equatable {
  const AdminBikeOrderState();

  @override
  List<Object> get props => [];
}

class AdminInitialState extends AdminBikeOrderState {}

class AdminLoadingState extends AdminBikeOrderState {}


// Define a new state to handle combined streams
class AdminGetCombinedOrdersState extends AdminBikeOrderState {
  final Stream<List<CustomizationOrderModel>> customizedOrders;
 final Stream<List<NewBikeOrderModel>>  newOrders;

  AdminGetCombinedOrdersState({
    required this.customizedOrders,
    required this.newOrders,
  });

  @override
  List<Object> get props => [customizedOrders, newOrders];
}



class AdminFailureState extends AdminBikeOrderState {
  final String errorMessage;

  AdminFailureState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

class AdminOrderDataIsSuccessfullyUpdatedState extends AdminBikeOrderState {}
