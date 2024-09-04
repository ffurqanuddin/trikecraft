part of 'carousel_slider_indicator_cubit.dart';

@immutable
class CarouselSliderIndicatorState {
  CarouselSliderIndicatorState({required this.index});
  int index;

  CarouselSliderIndicatorState copyWith(index) {
    return CarouselSliderIndicatorState(index: index ?? this.index);
  }
}
