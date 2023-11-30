import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
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
  File? imageFile;
  var imagePicker = ImagePicker();
  var pickedFilename;
  Future<void> pickProfileImage() async {
   final  pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      pickedFilename = pickedFile.path.split('/').last;
      imageFile = File(pickedFile.path);
      print (imageFile!.path);

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

          userModel=UserProfileModel.fromJson(value.data),
          emit(GetProfileSuccess())
    }).catchError((error){
      print(error.toString());
      if (error.toString().contains('401')||error.toString().contains('403')) {
        CashHelper.removeData(key: 'token');
        print('401');
      }
      print (token);

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

      userModel = UserProfileModel.fromJson(value.data),
      CashHelper.UpdateData(key: 'email', value: userModel!.data!.email),
      CashHelper.UpdateData(key: 'name', value: userModel!.data!.name),
      CashHelper.UpdateData(key: 'image', value: userModel!.data!.image),
      emit(UpdateProfileSuccess())
    }).catchError((error) {
      print(error.toString());
      if (error.toString().contains('401') ||
          error.toString().contains('403')) {
        CashHelper.removeData(key: 'token');
        print('401');
      }
      print(token);

      print(error.toString());
      emit(UpdateProfileError());
    });
  }
  Future<void> logout(BuildContext context) async {
    emit(LogoutLoadingState());

    try {
      var response = await DioHelper.postData(url: 'logout', token: token);

      CashHelper.removeData(key: 'token');
      CashHelper.removeData(key: 'name');
      CashHelper.removeData(key: 'image');
      CashHelper.removeData(key: 'email');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.data['message'].toString()),
          backgroundColor: Colors.green,
        ),
      );

      emit(LogoutSuccessState());
    } catch (error) {
      print(error.toString());
      emit(LogoutErrorState());
    }
  }





}
