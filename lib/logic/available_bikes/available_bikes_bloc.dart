import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:trikecraft/data/repository/bikes_data_repository.dart';

import '../../data/providers/bikes_data_provider.dart';

part 'available_bikes_event.dart';
part 'available_bikes_state.dart';

class AvailableBikesBloc
    extends Bloc<AvailableBikesEvent, AvailableBikesState> {
  final BikesDataRepository bikesDataRepository;
  AvailableBikesBloc({required this.bikesDataRepository})
      : super(AvailableBikesInitialState()) {
    on<AvailableBikesPageChangeEvent>(_recommandedBikesPageChangeEvent);
    on<AvailableBikesGetListEvent>(_recommandedBikesGetListEvent);
  }

  FutureOr<void> _recommandedBikesGetListEvent(
      AvailableBikesGetListEvent event, Emitter<AvailableBikesState> emit) {
    emit(AvailableBikesLoadingState());

    emit(AvailableBikesSuccessState(
        bikesList: bikesDataRepository.availableBikeList(), pageIndex: 0));
  }

  FutureOr<void> _recommandedBikesPageChangeEvent(
      AvailableBikesPageChangeEvent event, Emitter<AvailableBikesState> emit) {
    int index = event.pageIndex;
    event.controller.animateToPage(index,
        duration: Duration(milliseconds: 100), curve: Curves.linear);

    emit(AvailableBikesSuccessState(
        bikesList: bikesDataRepository.availableBikeList(), pageIndex: index));
  }
}
