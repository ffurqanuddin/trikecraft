part of 'available_bikes_bloc.dart';

sealed class AllAvailableBikesEvent extends Equatable {
  const AllAvailableBikesEvent();

  @override
  List<Object> get props => [];
}

class FetchAllAvailableBikesListEvent extends AllAvailableBikesEvent {}
