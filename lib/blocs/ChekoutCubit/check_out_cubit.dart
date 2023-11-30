import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketaby/model/check_out_model.dart';
import 'package:ketaby/model/place_order_failed_model.dart';
import 'package:ketaby/model/place_order_sucess_model.dart';
import 'package:ketaby/utils/dio_helper.dart';
import 'package:meta/meta.dart';

import '../../Views/main_screan.dart';
import '../../src/cashe_helper.dart';
import '../../utils/navigator.dart';

part 'check_out_state.dart';

class CheckOutCubit extends Cubit<CheckOutState> {
  CheckOutCubit() : super(CheckOutInitial());

  static CheckOutCubit get(context) => BlocProvider.of(context);
CheckOutModel? checkOutModel;
PlaceOrderSucessModel? placeOrderSucessModel;
PlaceOrderFailedModel? placeOrderFailedModel;
TextEditingController nameController = TextEditingController();
TextEditingController phoneController = TextEditingController();
TextEditingController addressController = TextEditingController();
TextEditingController emailController = TextEditingController();


  String ? token =CashHelper.getData(key: 'token').toString();
  Future getCheckOutData() async {
    emit(CheckOutLoadingState());
    DioHelper.getData(
      url: 'checkout',
      token: token,

    ).then((value) {
      print(value.data);
      checkOutModel = CheckOutModel.fromJson(value.data);
      emit(CheckOutSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(CheckOutErrorState(error.toString()));
    });
  }
  Future placeOrder({ required String governorate_id}) async {
    emit(PlaceOrderLoadingState());
    DioHelper.postData(
      url: 'place-order',
      token: token,
      data: {
        'name':nameController.text,
        'governorate_id': governorate_id,
        'phone':phoneController.text,
        'address':addressController.text,
        'email':emailController.text,
      }

    ).then((value) {

      print(value.data);
      if (value.data['status']==201){

        placeOrderSucessModel = PlaceOrderSucessModel.fromJson(value.data);
        emit(PlaceOrderSucessState(placeOrderSucessModel!.message.toString()));
      }
      // else if (value.data['status']==401|| value.data['status']==400|| value.data['status']==422){
      //   placeOrderFailedModel = PlaceOrderFailedModel.fromJson(value.data);
      //   emit(PlaceOrderFailureState(placeOrderFailedModel!.message.toString()));
      // }




    }).catchError((error) {
      // print(placeOrderFailedModel!.message);
      // placeOrderFailedModel = PlaceOrderFailedModel.fromJson(error.data);
      // emit(PlaceOrderFailureState(placeOrderFailedModel!.message.toString()));
      print(error.toString());
      emit(PlaceOrderFailureState(error.toString()));
    });
  }




}
