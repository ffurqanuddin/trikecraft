part of 'available_bikes_bloc.dart';

sealed class AvailableBikesEvent extends Equatable {
  const AvailableBikesEvent();

  @override
  List<Object> get props => [];
}


class FetchAvailableBikesListEvent extends AvailableBikesEvent{}
