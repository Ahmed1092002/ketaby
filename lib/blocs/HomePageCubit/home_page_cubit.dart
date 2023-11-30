import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketaby/model/CategoriesModel.dart';
import 'package:ketaby/model/NewArivalModel.dart';
import 'package:ketaby/model/best_seller_model.dart';
import 'package:ketaby/model/slider_model.dart';
import 'package:meta/meta.dart';

import '../../utils/dio_helper.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(HomePageInitial());

  static HomePageCubit get(context) => BlocProvider.of(context);
  SliderModel ? sliderModel;
  BestSellerModel ? bestSellerModel;
  CategoriesModel ? categoriesModel;
  NewArivalModel ? newArrivalModel;

  List<Widget> getImageSliders() {
    return sliderModel!.data!.sliders!
        .map((item) =>
        Container(
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              child: Image.network(item.image!, fit: BoxFit.cover, width: 1000.0),
            ),
          ),
        ))
        .toList();
  }

  List<Widget> imageSliders = [];

  Future getSliderData() async {
    emit(GetSliderLoading());
    await DioHelper.getData(url: 'sliders').then((value) {
      sliderModel = SliderModel.fromJson(value.data);
      imageSliders = getImageSliders();
      emit(GetSliderSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(GetSliderError());
    });
  }

  Future getBestSellerData() async {
    emit(GetBestSellerLoading());
    await DioHelper.getData(url: 'products-bestseller').then((value) {
      bestSellerModel = BestSellerModel.fromJson(value.data);

      emit(GetBestSellerSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(GetBestSellerError());
    });
  }
  Future getCategoryData() async {
    emit(GetCategoryLoading());
    await DioHelper.getData(url: 'categories').then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(GetCategorySuccess());
    }).catchError((error) {
      print(error.toString());
      emit(GetCategoryError());
    });
  }
  Future getNewAriavlData() async{
    emit(GetNewArrivalLoading());
    await DioHelper.getData(url: 'products-new-arrivals').then((value) {
      newArrivalModel = NewArivalModel.fromJson(value.data);
      emit(GetNewArrivalSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(GetNewArrivalError());
    });
  }
}