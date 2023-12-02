import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ketaby/Views/main_screan.dart';
import 'package:ketaby/model/UserModel.dart';
import 'package:ketaby/utils/dio_helper.dart';
import 'package:ketaby/utils/navigator.dart';
import 'package:meta/meta.dart';

import '../../src/cashe_helper.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  static RegisterCubit get(context) => BlocProvider.of(context);
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  UserModel? userModel;
  var storage = const FlutterSecureStorage();

 register ({
  required String name,
  required String email,
  required String password,
  required String confirmPassword

})async {
  var data ={

    'name': name,
    'email': email,
    'password': password,
    'password_confirmation': confirmPassword
  };




  emit(RegisterLoading());
  DioHelper.postData(url: "register", data: data).

  then((value) async {

    print(value.data);
    if (value.statusCode == 422) {
      userModel = UserModel.fromJson(value.data);
      print(userModel!.errors);
      emit(RegisterError(userModel!.errors!.toString()));
    }
    else {

      userModel = UserModel.fromJson(value.data);
      CashHelper.saveData(
          key: 'token', value:userModel!.data!.token);
      CashHelper.saveData(
          key: 'image', value: userModel!.data!.user!.image!);
      CashHelper.saveData(
          key: 'email', value: userModel!.data!.user!.email!);
      CashHelper.saveData(
          key: 'name', value: userModel!.data!.user!.name!);

      emit(RegisterSuccess(userModel!));
    }

  }).catchError((error) {
    if (error.response!.statusCode == 422) {
     userModel = UserModel.fromJson(error.response!.data);
      print(userModel!.errors);
      emit(RegisterError(userModel!.errors!.toString()));

    } else {
      print(error.toString());
      emit(RegisterError(error.toString()));

    }
  });




}


}
