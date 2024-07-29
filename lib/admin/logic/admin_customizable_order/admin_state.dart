part of 'admin_customizable_orders_cubit.dart';

abstract class AdminCustomizableOrderState extends Equatable {
  const AdminCustomizableOrderState();

  @override
  List<Object> get props => [];
}

class AdminInitialState extends AdminCustomizableOrderState {}

class AdminLoadingState extends AdminCustomizableOrderState {}

class AdminGetListCustomizedOrderState extends AdminCustomizableOrderState {
  final Stream<List<CustomizationOrderModel>> OrdersList;

  AdminGetListCustomizedOrderState({required this.OrdersList});

  @override
  List<Object> get props => [OrdersList];
}

class AdminGetListNewOrderState extends AdminCustomizableOrderState {
  final Stream<List<NewOrderModel>> OrdersList;

  AdminGetListNewOrderState({required this.OrdersList});

  @override
  List<Object> get props => [OrdersList];
}

class AdminFailureState extends AdminCustomizableOrderState {
  final String errorMessage;

  AdminFailureState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

class AdminOrderDataIsSuccessfullyUpdatedState
    extends AdminCustomizableOrderState {}
