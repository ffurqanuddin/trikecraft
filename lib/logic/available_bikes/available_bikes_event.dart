part of 'available_bikes_bloc.dart';

sealed class AvailableBikesEvent extends Equatable {
  const AvailableBikesEvent();

  @override
  List<Object> get props => [];
}

class AvailableBikesPageChangeEvent extends AvailableBikesEvent {
  final int pageIndex;
  final PageController controller;
  AvailableBikesPageChangeEvent(
      {required this.pageIndex, required this.controller});

  @override
  List<Object> get props => [
        pageIndex,
      ];
}

class AvailableBikesGetListEvent extends AvailableBikesEvent {}
