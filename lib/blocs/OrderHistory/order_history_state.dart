part of 'order_history_cubit.dart';

@immutable
abstract class OrderHistoryState {}

class OrderHistoryInitial extends OrderHistoryState {}
class GetOrderDataError extends OrderHistoryState {}
class GetOrderDataSuccess extends OrderHistoryState {
  final OrderHistoryModel orderModel;

  GetOrderDataSuccess(this.orderModel);
}
class GetOrderDataLoading extends OrderHistoryState {}


