import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketaby/Views/login_screan.dart';
import 'package:ketaby/model/user_profile_model.dart';
import 'package:ketaby/src/cashe_helper.dart';
import 'package:ketaby/utils/navigator.dart';
import 'package:meta/meta.dart';

import '../../utils/dio_helper.dart';

part 'change_password_and_delete_account_state.dart';

class ChangePasswordAndDeleteAccountCubit extends Cubit<ChangePasswordAndDeleteAccountState> {
  ChangePasswordAndDeleteAccountCubit() : super(ChangePasswordAndDeleteAccountInitial());

  static ChangePasswordAndDeleteAccountCubit get(context) => BlocProvider.of(context);
  UserProfileModel? userModel;
  String token = CashHelper.getData(key: 'token').toString() ?? '';

  Future<void> deleteAccount({BuildContext? context ,String ? currentPassword}) async {
    emit(DeleteProfileLoading());

    try {
      var response = await DioHelper.postData(url: 'delete-profile',
 data: {  'current_password': currentPassword},
          token: token);

      CashHelper.removeData(key: 'token');
      CashHelper.removeData(key: 'name');
      CashHelper.removeData(key: 'image');
      CashHelper.removeData(key: 'email');

      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text(response.data['message'].toString()),
          backgroundColor: Colors.green,
        ),
      );


      emit(DeleteProfileSuccess());
    } catch (error) {
      print(error.toString());
      emit(DeleteProfileError());
    }
  }
  Future<void> changePassword({BuildContext? context,String? oldPassword,String? newPassword,String? confirmPassword}) async {
    emit(ChangePasswordLoading());

    try {
      var response = await DioHelper.postData(url: 'change-password', token: token,data: {
        'current_password': oldPassword,
        'new_password': newPassword,
        'new_password_confirmation': confirmPassword,
      });



      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          content: Text(response.data['message'].toString()),
          backgroundColor: Colors.green,
        ),
      );

      emit(ChangePasswordSuccess());
    } catch (error) {
      print(error.toString());
      emit(ChangePasswordError());
    }
    close();
  }


}
