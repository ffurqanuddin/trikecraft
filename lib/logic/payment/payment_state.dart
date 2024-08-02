part of 'payment_cubit.dart';

sealed class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

final class PaymentInitialState extends PaymentState {}
final class PaymentLoadingState extends PaymentState {}


final class PaymentSuccessState extends PaymentState {

}

final class PaymentFailureState extends PaymentState {
  PaymentFailureState({required this.message});

  final message;


  @override
  List<Object> get props => [message];
}


