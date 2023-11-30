part of 'check_out_cubit.dart';

@immutable
abstract class CheckOutState {}

class CheckOutInitial extends CheckOutState {}

class CheckOutLoadingState extends CheckOutState {}

class CheckOutSuccessState extends CheckOutState {}

class CheckOutErrorState extends CheckOutState {
  final String error;

  CheckOutErrorState(this.error);
}

class PlaceOrderFailureState extends CheckOutState {
  final String error;

  PlaceOrderFailureState(this.error);
}

class PlaceOrderSucessState extends CheckOutState {
  final String message;

  PlaceOrderSucessState(this.message);
}
class PlaceOrderLoadingState extends CheckOutState {}


