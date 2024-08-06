part of 'admin_product_cubit.dart';

sealed class AdminProductState extends Equatable {
  const AdminProductState();

  @override
  List<Object> get props => [];
}

final class AdminProductInitialState extends AdminProductState {}

final class AdminProductLoadingState extends AdminProductState {}

final class AdminProductFailureState extends AdminProductState {
  final String errorMessage;

  AdminProductFailureState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

final class AdminGetProductSuccessState extends AdminProductState {
  final List<BikeModel> products;

  AdminGetProductSuccessState({required this.products});
  @override
  List<Object> get props => [products];
}

final class AdminUpdateProductSuccessState extends AdminProductState {}
final class AdminNewProductSuccessfullyAddedState extends AdminProductState {}

final class AdminDeletedProductSuccessState extends AdminProductState {}
final class AdminProductEmptyState extends AdminProductState {}


