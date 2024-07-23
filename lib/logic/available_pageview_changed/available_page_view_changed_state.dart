part of 'available_page_view_changed_cubit.dart';

 class AvailablePageViewChangedState extends Equatable {
  const AvailablePageViewChangedState({required this.pageIndex});

  final int pageIndex;


  AvailablePageViewChangedState copyWith({required index}){
    return AvailablePageViewChangedState(pageIndex: index??this.pageIndex);
  }
  @override
  List<Object> get props => [pageIndex];
}


