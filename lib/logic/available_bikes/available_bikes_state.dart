part of 'available_bikes_bloc.dart';

sealed class AvailableBikesState extends Equatable {
  const AvailableBikesState();

  @override
  List<Object> get props => [];
}

final class AvailableBikesInitialState extends AvailableBikesState {}

final class AvailableBikesLoadingState extends AvailableBikesState {}

final class AvailableBikesSuccessState extends AvailableBikesState {
  AvailableBikesSuccessState({required this.bikes});

  final List<BikeModel> bikes;
}

final class AvailableBikesErrorState extends AvailableBikesState {
  AvailableBikesErrorState({required this.errorMessage});

  final String errorMessage;
}
