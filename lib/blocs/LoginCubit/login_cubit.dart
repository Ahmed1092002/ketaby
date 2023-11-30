import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';

import '../../model/UserModel.dart';
import '../../src/cashe_helper.dart';
import '../../utils/dio_helper.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  UserModel? userModel;
  var storage = const FlutterSecureStorage();


  login (
  {
    required String email,
    required String password,
  }
      )async {
    var data ={
      'email': email,
      'password': password,
    };
    emit(LoginLoading());
    DioHelper.postData(url: "login", data: data).
    then((value) async {
      print(value.data);

      userModel = UserModel.fromJson(value.data);
      print (userModel!.data!.token);
      // await storage.write(key: 'token', value: userModel!.data!.token);
      CashHelper.saveData(
          key: 'token', value:userModel!.data!.token);

      emit(LoginSuccess(userModel!));
    }).catchError((error) {
      if (error.response!.statusCode == 422) {
        print(error.response!.data);
        emit(LoginError(error.response!.data['message']));
      } else {
        print(error.toString());
        emit(LoginError(error.toString()));
      }
    });
  }



}
