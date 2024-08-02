import 'package:equatable/equatable.dart';

import '../../models/order_model.dart';

abstract class NewBikeOrderState extends Equatable {
  const NewBikeOrderState();
  @override
  List<Object> get props => [];
}

class NewBikeOrderInitialState extends NewBikeOrderState {}

class NewBikeOrderDataLoadingState extends NewBikeOrderState {}

class NewBikeOrderDataSuccessfullySavedState extends NewBikeOrderState {}

class NewBikeOrderDataSavingFailureState extends NewBikeOrderState {
  final String errorMessage;

  const NewBikeOrderDataSavingFailureState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

class NewBikeOrderDataLoadedState extends NewBikeOrderState {
  final List<NewBikeOrderModel> orders;

  const NewBikeOrderDataLoadedState({required this.orders});

  @override
  List<Object> get props => [orders];
}

class NewBikeOrderDataLoadingFailureState extends NewBikeOrderState {
  final String errorMessage;

  const NewBikeOrderDataLoadingFailureState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
