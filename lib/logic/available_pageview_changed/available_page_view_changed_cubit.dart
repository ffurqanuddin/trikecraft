import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'available_page_view_changed_state.dart';

class AvailablePageViewChangedCubit
    extends Cubit<AvailablePageViewChangedState> {
  AvailablePageViewChangedCubit()
      : super(AvailablePageViewChangedState(pageIndex: 0));

  changedPage(index) {
    emit(state.copyWith(index: index));
  }
}
