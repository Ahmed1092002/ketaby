part of 'cart_cubit.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}
class GetCartLoadingState extends CartState {}
class GetCartSuccessState extends CartState {}
class GetCartErrorState extends CartState {
  final String error;
  GetCartErrorState(this.error);
}
class AddToCartLoadingState extends CartState {}
class AddToCartSuccessState extends CartState {}
class AddToCartErrorState extends CartState {
  final String error;
  AddToCartErrorState(this.error);
}
class DeleteFromCartLoadingState extends CartState {}
class DeleteFromCartSuccessState extends CartState {}
class DeleteFromCartErrorState extends CartState {
  final String error;
  DeleteFromCartErrorState(this.error);
}
class UpdateCartLoadingState extends CartState {}
class UpdateCartSuccessState extends CartState {}
class UpdateCartErrorState extends CartState {
  final String error;
  UpdateCartErrorState(this.error);
}

