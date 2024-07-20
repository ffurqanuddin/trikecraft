part of 'available_bikes_bloc.dart';

sealed class AvailableBikesState extends Equatable {
  const AvailableBikesState();

  @override
  List<Object> get props => [];
}

final class AvailableBikesInitialState extends AvailableBikesState {}

final class AvailableBikesLoadingState extends AvailableBikesState {}

final class AvailableBikesSuccessState extends AvailableBikesState {
  AvailableBikesSuccessState(
      {required this.bikesList, required this.pageIndex});
  final List<AvailableBikeModel> bikesList;
  final int pageIndex;

  @override
  List<Object> get props => [bikesList, pageIndex];
}
