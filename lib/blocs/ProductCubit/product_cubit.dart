import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketaby/model/ProductModel.dart';
import 'package:ketaby/utils/dio_helper.dart';
import 'package:meta/meta.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());
  static ProductCubit get(context) => BlocProvider.of(context);
  ProductModel? productModel;
  Future getProductData() async {
    emit(ProductLoadingState());
   DioHelper.getData(url: 'products').then((value) {
      productModel = ProductModel.fromJson(value.data);
      emit(ProductSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ProductErrorState(error.toString()));
    });
  }
Future getWisListData() async {
    emit(GetWishListLoadingState());
   DioHelper.getData(url: 'wishlist').then((value) {
      productModel = ProductModel.fromJson(value.data);
      emit(GetWishListSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetWishListErrorState(error.toString()));
    });
  }

}
