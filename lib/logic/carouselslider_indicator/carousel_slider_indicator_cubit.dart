import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'carousel_slider_indicator_state.dart';

class CarouselSliderIndicatorCubit extends Cubit<CarouselSliderIndicatorState> {
  CarouselSliderIndicatorCubit()
      : super(CarouselSliderIndicatorState(index: 0));

  updateIndicatorIndex(index) {
    emit(state.copyWith(index));
  }
}
