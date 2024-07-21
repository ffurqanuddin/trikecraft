part of 'customized_bike_order_bloc.dart';

abstract class CustomizedBikeOrderState extends Equatable {
  const CustomizedBikeOrderState();

  @override
  List<Object> get props => [];
}

class CustomizedBikeOrderInitialState extends CustomizedBikeOrderState {}

class CustomizedBikeOrderDataLoadingState extends CustomizedBikeOrderState {}

class CustomizedBikeOrderDataSuccessfullySavedState
    extends CustomizedBikeOrderState {}

class CustomizedBikeOrderDataSavingFailureState
    extends CustomizedBikeOrderState {
  final String errorMessage;

  const CustomizedBikeOrderDataSavingFailureState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

class CustomizedBikeOrderDataLoadedState extends CustomizedBikeOrderState {
  final List<CustomizationOrderModel> orders;

  const CustomizedBikeOrderDataLoadedState({required this.orders});

  @override
  List<Object> get props => [orders];
}

class CustomizedBikeOrderDataLoadingFailureState
    extends CustomizedBikeOrderState {
  final String errorMessage;

  const CustomizedBikeOrderDataLoadingFailureState(
      {required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

class CustomizedBikeOrderDataCancelLoadingState
    extends CustomizedBikeOrderState {
  const CustomizedBikeOrderDataCancelLoadingState();
}

class CustomizedBikeOrderDataSuccessfullyCanceledState
    extends CustomizedBikeOrderState {
  const CustomizedBikeOrderDataSuccessfullyCanceledState();
}


class CustomizedBikeOrderDataCancelFailureState
    extends CustomizedBikeOrderState {
  const CustomizedBikeOrderDataCancelFailureState({required this.errorMessage});

  final String errorMessage;

}
