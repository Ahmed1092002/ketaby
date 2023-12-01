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
class SearchLoadingState extends ProductState {}
class SearchSuccessState extends ProductState {}
class SearchErrorState extends ProductState {}
class AddToWishListLoadingState extends ProductState {}
class AddToWishListSuccessState extends ProductState {}
class AddToWishListErrorState extends ProductState {
  final String error;
  AddToWishListErrorState(this.error);
}
class RemoveWishListLoadingState extends ProductState {}
class RemoveWishListSuccessState extends ProductState {}
class RemoveWishListErrorState extends ProductState {
  final String error;
  RemoveWishListErrorState(this.error);
}

