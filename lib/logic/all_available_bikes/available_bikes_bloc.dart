import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trikecraft/data/repository/bikes_data_repository.dart';

import '../../models/bike_model.dart';

part 'available_bikes_event.dart';
part 'available_bikes_state.dart';

class AllAvailableBikesBloc
    extends Bloc<AllAvailableBikesEvent, AllAvailableBikesState> {
  final BikesDataRepository bikesDataRepository;

  AllAvailableBikesBloc({required this.bikesDataRepository})
      : super(AllAvailableBikesInitialState()) {
    on<FetchAllAvailableBikesListEvent>(_fetchAvailableBikesListEvent);
  }

  Future<FutureOr<void>> _fetchAvailableBikesListEvent(
      FetchAllAvailableBikesListEvent event,
      Emitter<AllAvailableBikesState> emit) async {
    emit(AllAvailableBikesLoadingState());

    try {
      await bikesDataRepository.getAvailableBikesFromFirestore().then((data) {
        print("Data from Available Bikes Repository\n ${data}");
        emit(AllAvailableBikesSuccessState(bikes: data));
      }).onError(
        (error, stackTrace) {
          emit(AllAvailableBikesErrorState(errorMessage: error.toString()));
        },
      );
    } catch (e) {
      emit(AllAvailableBikesErrorState(errorMessage: e.toString()));
    }
  }
}
