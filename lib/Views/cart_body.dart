import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketaby/Views/check_out_screan.dart';
import 'package:ketaby/utils/navigator.dart';
import 'package:ketaby/widgets/check_out_card.dart';
import 'package:ketaby/widgets/cart_item_container.dart';

import '../blocs/CartCubit/cart_cubit.dart';

class CartBody extends StatefulWidget {
  const CartBody({Key? key}) : super(key: key);

  @override
  State<CartBody> createState() => _CartBodyState();
}

class _CartBodyState extends State<CartBody> {
  @override
  void initState() {
    // TODO: implement initState
    CartCubit.get(context).getCartData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        if (state is GetCartErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
        }
        if (state is GetCartSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('success'),
            ),
          );
        }
        if (state is DeleteFromCartErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
        }
        if (state is DeleteFromCartSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('success'),
            ),
          );
        }
        if (state is UpdateCartErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
        }
        if (state is UpdateCartSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('success'),
            ),
          );
        }

      },
      builder: (context, state) {
        var cubit = CartCubit.get(context);
        if (cubit.cartModel == null || state is GetCartLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (cubit.cartModel!.data!.cartItems!.isEmpty || cubit.cartModel!.message == 'no items in cart') {
          return Center(
            child: Text(cubit.cartModel!.message!),
          );
        }
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: ListView.builder(
                    itemCount: cubit.cartModel!.data!.cartItems!.length,
                    itemBuilder: (context, index) => CartItemContainer(
                        name: cubit
                            .cartModel!.data!.cartItems![index].itemProductName,
                        addItem: () {
                          if (cubit.cartModel!.data!.cartItems![index]
                                  .itemQuantity! <
                              cubit.cartModel!.data!.cartItems![index]
                                  .itemProductStock!) {
                            int quantity = cubit.cartModel!.data!
                                    .cartItems![index].itemQuantity!.toInt() +
                                1;

                            cubit.updateCartData(
                                cartItemId: cubit
                                    .cartModel!.data!.cartItems![index].itemId!
                                    .toInt(),
                                quantity: quantity);

                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('out of stock'),
                              ),
                            );
                          }
                        },
                        quantity: cubit
                            .cartModel!.data!.cartItems![index].itemQuantity!.toInt(),
                        oldPrice: cubit
                            .cartModel!.data!.cartItems![index].itemProductPrice
                            .toString(),
                        removeItem: () {
                          if (cubit.cartModel!.data!.cartItems![index]
                                  .itemQuantity! >
                              1) {
                            int quantity = cubit.cartModel!.data!
                                    .cartItems![index].itemQuantity!.toInt() -
                                1;
                            cubit.updateCartData(
                                cartItemId: cubit
                                    .cartModel!.data!.cartItems![index].itemId!
                                    .toInt(),
                                quantity: quantity);

                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text('item quantity must be more than 1'),
                              ),
                            );
                          }
                        },
                        removeProductFromCart: () {
                          cubit.deleteFromCartData(
                              cartItemId: cubit
                                  .cartModel!.data!.cartItems![index].itemId!
                                  .toInt());
                        },

                        image: cubit.cartModel!.data!.cartItems![index]
                            .itemProductImage,
                        price: cubit.cartModel!.data!.cartItems![index]
                            .itemProductPriceAfterDiscount!.toDouble()),
                  )),
              CheckOutCard(
                totalPrice: cubit.cartModel!.data!.total.toString(),
                lapel: 'Check Out',
                onPressed: (){
                  navigateToScreen(context, CheckOutScrean());

                },
              )
            ],
          ),
        );
      },
    );
  }
}
