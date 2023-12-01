import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketaby/model/NoOrderHistoryModel.dart';
import 'package:ketaby/utils/dio_helper.dart';
import 'package:meta/meta.dart';

import '../../model/order_history_model.dart';
import '../../src/cashe_helper.dart';

part 'order_history_state.dart';

class OrderHistoryCubit extends Cubit<OrderHistoryState> {
  OrderHistoryCubit() : super(OrderHistoryInitial());
  static OrderHistoryCubit get(context) => BlocProvider.of(context);
  OrderHistoryModel? orderHistoryModel;
  NoOrderHistoryModel? noOrderHistoryModel;
  String token = CashHelper.getData(key: 'token').toString() ?? '';

  Future getOrderData() async {
    emit(GetOrderDataLoading());
    DioHelper.getData(url: 'order-history', token: token)
        .then((value) =>
    {
     // if (value.data['message'].toString()==('No Orders To Show'))
     //   {
     //     print (value.data['message'].toString()),
     //      noOrderHistoryModel = NoOrderHistoryModel.fromJson(value.data),
     //   } else {
     //
     //
     // }
      orderHistoryModel = OrderHistoryModel.fromJson(value.data),
      emit(GetOrderDataSuccess(orderHistoryModel!))

    }).catchError((error) {
      print(error.toString());


      print(error.toString());
      emit(GetOrderDataError());
    });
  }
}
