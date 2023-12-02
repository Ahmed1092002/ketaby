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

  Future<void> deleteAccount({String ? currentPassword}) async {
    emit(DeleteProfileLoading());

    try {
      var response = await DioHelper.postData(url: 'delete-profile',
 data: {  'current_password': currentPassword},
          token: token);

      CashHelper.removeData(key: 'token');
      CashHelper.removeData(key: 'name');
      CashHelper.removeData(key: 'image');
      CashHelper.removeData(key: 'email');

      print (response.data);


      emit(DeleteProfileSuccess());
    } catch (error) {
      print(error.toString());
      emit(DeleteProfileError());
    }
  }
   changePassword({String? oldPassword,String? newPassword,String? confirmPassword}) async {

      emit(ChangePasswordLoading());
        DioHelper.postData(url: 'update-password', token: token,data: {
        'current_password': oldPassword,
        'new_password': newPassword,
        'new_password_confirmation': confirmPassword,
      }).then((value) => {
        print(value.statusCode),
      if (value.statusCode==200) {
         print (value.data),
        userModel = UserProfileModel.fromJson(value.data),
        emit(ChangePasswordSuccess())

      } else {
         print (value.data),
         userModel = UserProfileModel.fromJson(value.data),
         emit(ChangePasswordError())

       }






      }).catchError((error) {
        print(error.toString());

          emit(ChangePasswordError());
            });




  }


}
