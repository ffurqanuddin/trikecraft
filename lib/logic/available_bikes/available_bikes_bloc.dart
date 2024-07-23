import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trikecraft/data/repository/bikes_data_repository.dart';

import '../../models/bike_model.dart';

part 'available_bikes_event.dart';
part 'available_bikes_state.dart';

class AvailableBikesBloc
    extends Bloc<AvailableBikesEvent, AvailableBikesState> {
  final BikesDataRepository bikesDataRepository;

  AvailableBikesBloc({required this.bikesDataRepository})
      : super(AvailableBikesInitialState()) {
    on<FetchAvailableBikesListEvent>(_fetchAvailableBikesListEvent);
  }

  Future<FutureOr<void>> _fetchAvailableBikesListEvent(
      FetchAvailableBikesListEvent event, Emitter<AvailableBikesState> emit) async {
    emit(AvailableBikesLoadingState());

    try {
     await bikesDataRepository.getAvailableBikesFromFirestore().then((data) {
      print("Data from Available Bikes Repository\n ${data}");
        emit(AvailableBikesSuccessState(bikes: data));
      }).onError(
        (error, stackTrace) {
          emit(AvailableBikesErrorState(errorMessage: error.toString()));
        },
      );
    } catch (e) {
      emit(AvailableBikesErrorState(errorMessage: e.toString()));
    }
  }
}
