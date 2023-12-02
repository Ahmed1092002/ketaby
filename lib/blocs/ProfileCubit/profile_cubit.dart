import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ketaby/model/UpdateErrorModel.dart';
import 'package:ketaby/model/order_history_model.dart';
import 'package:ketaby/model/user_profile_model.dart';
import 'package:ketaby/src/cashe_helper.dart';
import 'package:ketaby/utils/dio_helper.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  static ProfileCubit get(context) => BlocProvider.of(context);
  UserProfileModel? userModel;
  String token = CashHelper.getData(key: 'token').toString() ?? '';
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  UpdateErrorModel? updateErrorModel;
  File? imageFile;
  var imagePicker = ImagePicker();
  var pickedFilename;
  int statuesCode = 0;
  Future<void> pickProfileImage() async {
   final  pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      pickedFilename = pickedFile.path.split('/').last;
      print (pickedFilename);
      // pickedFilename = pickedFile.name;
      imageFile = File(pickedFile.path);

      emit(ProfileImagePickedSuccessState());

    } else {
      print('No image selected.');
      emit(ProfileImagePickedErrorState());
    }
  }

  Future getProfileData() async{
    emit(GetProfileLoading());
    DioHelper.getData(url: 'profile', token: token)
        .then((value) => {
          print(value.statusCode),
    if (value.statusCode==401||value.statusCode==403) {
        CashHelper.removeData(key: 'token'),
    CashHelper.removeData(key: 'name'),
    CashHelper.removeData(key: 'image'),
    CashHelper.removeData(key: 'email'),
    emit(GetProfileError())
  }else
    { userModel=UserProfileModel.fromJson(value.data),
    emit(GetProfileSuccess())}
    }).catchError((error){


      print(error.toString());
      emit(GetProfileError());
    });
    

  }
  Future updateProfileData() async {
    emit(UpdateProfileLoading());
    FormData formData = FormData.fromMap({
      'name': nameController.text,
      'email': emailController.text,
      'phone': phoneController.text,
      'address': addressController.text,
      'city': cityController.text,
      if (imageFile != null && imageFile!.path.isNotEmpty && pickedFilename != null)
        'image': [
          await MultipartFile.fromFile(
            imageFile!.path,
            filename: pickedFilename,
          ),
        ],


    });
    DioHelper.postData(url: 'update-profile', token: token, data: formData)
        .then((value) =>
    {
      print(value.statusCode),
if (value.statusCode==422) {
updateErrorModel = UpdateErrorModel.fromJson(value.data),
emit(UpdateProfileError())

}else
  {
                  userModel = UserProfileModel.fromJson(value.data),
                  CashHelper.UpdateData(
                      key: 'email', value: userModel!.data!.email),
                  CashHelper.UpdateData(
                      key: 'name', value: userModel!.data!.name),
                  CashHelper.UpdateData(
                      key: 'image', value: userModel!.data!.image),
                  emit(UpdateProfileSuccess())
                }
            }).catchError((error) {
      print(error.toString());

      print(error.toString());
      emit(UpdateProfileError());
    });
  }
  Future logout() async {
    if (state is! LogoutLoadingState) {
      emit(LogoutLoadingState());
    }

    try {
      var response = await DioHelper.postData(url: 'logout', token: token);

      CashHelper.removeData(key: 'token');
      CashHelper.removeData(key: 'name');
      CashHelper.removeData(key: 'image');
      CashHelper.removeData(key: 'email');

print (response.data);
print (response.statusCode);
statuesCode = response.statusCode!;

      if (state is! LogoutLoadingState) {
        emit(LogoutSuccessState());
      }
    } catch (error) {
      print(error.toString());
      emit(LogoutErrorState());
    }
  }






}
