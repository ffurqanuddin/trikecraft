import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:one_context/one_context.dart';
import 'package:trikecraft/base/di/dependency_injection.dart';
import 'package:trikecraft/logic/all_available_bikes/available_bikes_bloc.dart';
import 'package:trikecraft/logic/check_internet/check_internet_event.dart';
import 'package:trikecraft/logic/check_internet/check_internet_state.dart';
import 'package:trikecraft/logic/customized_bike_order/customized_bike_order_bloc.dart';

class CheckInternetConnectionBloc
    extends Bloc<CheckInternetConnectionEvent, CheckInternetConnectionState> {
  final Connectivity _connectivity = getIt.get<Connectivity>();
  StreamSubscription? _connectivitySubscription;

  CheckInternetConnectionBloc() : super(CheckInternetConnectionInitial()) {
    on<CheckInternetConnectionStatusEvent>(_onCheckStatus);
    on<InternetConnectionChangedEvent>(_onConnectionChanged);

    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> _onCheckStatus(CheckInternetConnectionStatusEvent event, Emitter<CheckInternetConnectionState> emit) async {
    try {
      final result = await _connectivity.checkConnectivity();
      final isConnected = result.contains(ConnectivityResult.mobile) || result.contains(ConnectivityResult.wifi);
      emit(isConnected ? InternetConnectedState() : NoInternetConnectionState());
    } catch (_) {
      emit(NoInternetConnectionState());
    }
  }

  void _onConnectionChanged(InternetConnectionChangedEvent event, Emitter<CheckInternetConnectionState> emit) {
    if (event.isConnected) {
      emit(InternetConnectedState());
      _triggerDataRefresh();
    } else {
      emit(NoInternetConnectionState());
    }
  }

  void _updateConnectionStatus(List<ConnectivityResult> result) async {
    if (result.isEmpty || (result.length == 1 && result.first == ConnectivityResult.none)) {
      add(InternetConnectionChangedEvent(false));
    } else {
      // Double-check internet connectivity
      bool isActuallyConnected = await _checkActualConnectivity();
      add(InternetConnectionChangedEvent(isActuallyConnected));
    }
  }

  Future<bool> _checkActualConnectivity() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  void _triggerDataRefresh() {
    final context = OneContext().context;
    if (context != null) {
      context.read<AllAvailableBikesBloc>().add(FetchAllAvailableBikesListEvent());
      context.read<CustomizedBikeOrderBloc>().add(LoadCustomizedBikeOrderDataEvent());
    }
  }

  @override
  Future<void> close() {
    _connectivitySubscription?.cancel();
    return super.close();
  }
}