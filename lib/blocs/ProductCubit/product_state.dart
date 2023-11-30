part of 'product_cubit.dart';

@immutable
abstract class ProductState {}

class ProductInitial extends ProductState {}
class ProductLoadingState extends ProductState {}
class ProductSuccessState extends ProductState {}
class ProductErrorState extends ProductState {
  final String error;
  ProductErrorState(this.error);
}
class GetWishListLoadingState extends ProductState {}
class GetWishListSuccessState extends ProductState {}
class GetWishListErrorState extends ProductState {
  final String error;
  GetWishListErrorState(this.error);
}
