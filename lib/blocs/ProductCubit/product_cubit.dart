import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketaby/model/ProductModel.dart';
import 'package:ketaby/model/WishListModel.dart';
import 'package:ketaby/src/cashe_helper.dart';
import 'package:ketaby/utils/dio_helper.dart';
import 'package:meta/meta.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());
  static ProductCubit get(context) => BlocProvider.of(context);
  ProductModel? productModel;
  WishListModel? wishListModel;
  String token = CashHelper.getData(key: 'token').toString() ?? '';
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
   DioHelper.getData(url: 'wishlist',token: token).then((value) {
      wishListModel = WishListModel.fromJson(value.data);
      onWishList();
      emit(GetWishListSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetWishListErrorState(error.toString()));
    });
  }
Future addToWishListData({required int id}) async {
    emit(AddToWishListLoadingState());
    DioHelper.postData(url: 'add-to-wishlist', data: {'product_id': id},token: token).then((value) {
      getWisListData();

      emit(AddToWishListSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(AddToWishListErrorState(error.toString()));
    });
  }
  Future deleteFromWishListData({required int id}) async {
    emit(RemoveWishListLoadingState());
    DioHelper.postData(url: 'remove-from-wishlist', data: {'product_id': id},token: token).then((value) {
      getWisListData();
      emit(RemoveWishListSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(RemoveWishListErrorState(error.toString()));
    });
  }
  Future searchProducts(String search) async {
    emit(SearchLoadingState());
    DioHelper.getData(url: 'products-search?name=$search',
    ).then((value) {
      print(value.statusCode);
productModel = ProductModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorState());
    });

  }
  List <int> wishList = [];
  onWishList() {
    var wishlistData = wishListModel!.data!.data!;

    for (int i = 0; i < wishlistData.length; i++) {
      int? count = 0;
      count = wishlistData[i].id;

      wishList.add(count!);
    }
  }

  }
