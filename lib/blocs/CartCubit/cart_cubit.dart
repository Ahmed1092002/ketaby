import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ketaby/model/CartModel.dart';
import 'package:ketaby/src/cashe_helper.dart';
import 'package:ketaby/utils/dio_helper.dart';
import 'package:meta/meta.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  static CartCubit get(context) => BlocProvider.of(context);
   CartModel? cartModel;
   String ? token =CashHelper.getData(key: 'token').toString();
   var storage=FlutterSecureStorage();
 Future getCartData() async {
   print (token);
    emit(GetCartLoadingState());
    DioHelper.getData(url: 'cart',token: token).then((value) {
      cartModel = CartModel.fromJson(value.data);
      emit(GetCartSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetCartErrorState(error.toString()));
    });
  }
   addToCartData({ required int id}) async {

     emit(AddToCartLoadingState());
    DioHelper.postData(url: 'add-to-cart',token: token, data: {
      'product_id': '$id',
    }).then((value) {
      cartModel = CartModel.fromJson(value.data);
      emit(AddToCartSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(AddToCartErrorState(error.toString()));
    });
  }

  Future deleteFromCartData({

    required int cartItemId,



}) async {

    emit(DeleteFromCartLoadingState());
    DioHelper.postData(url: 'remove-from-cart'
    ,token: token,
      data: {
        'cart_item_id': '$cartItemId',
      },
    ).then((value) {
      cartModel = CartModel.fromJson(value.data);
      emit(DeleteFromCartSuccessState());
    }).catchError((error) {

      print(error.toString());
      emit(DeleteFromCartErrorState(error.toString()));
    });
  }
  Future updateCartData({

    required int cartItemId,
    required int quantity,

  }) async {

    emit(UpdateCartLoadingState());
    DioHelper.postData(url: 'update-cart', data: {

      'cart_item_id': cartItemId.toString(),
      'quantity': quantity.toString(),


    }
    ,token: token).then((value) {
      cartModel = CartModel.fromJson(value.data);
      emit(UpdateCartSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(UpdateCartErrorState(error.toString()));
    });
  }
}
