part of 'available_bikes_bloc.dart';

sealed class AllAvailableBikesState extends Equatable {
  const AllAvailableBikesState();

  @override
  List<Object> get props => [];
}

final class AllAvailableBikesInitialState extends AllAvailableBikesState {}

final class AllAvailableBikesLoadingState extends AllAvailableBikesState {}

final class AllAvailableBikesSuccessState extends AllAvailableBikesState {
  AllAvailableBikesSuccessState({required this.bikes});

  final List<BikeModel> bikes;
}

final class AllAvailableBikesErrorState extends AllAvailableBikesState {
  AllAvailableBikesErrorState({required this.errorMessage});

  final String errorMessage;
}
