import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketaby/widgets/books_container.dart';

import '../blocs/CartCubit/cart_cubit.dart';
import '../blocs/ProductCubit/product_cubit.dart';

class WishListBody extends StatefulWidget {
  const WishListBody({Key? key}) : super(key: key);

  @override
  _WishListBodyState createState() => _WishListBodyState();
}

class _WishListBodyState extends State<WishListBody> {
  IconData? icon;
  @override
  void initState() {
    // TODO: implement initState
    ProductCubit.get(context).getWisListData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
      return BlocConsumer<ProductCubit, ProductState>(
      listener: (context, state) {
        if (state is GetWishListSuccessState) {
          print('success');
        }
        if (state is GetWishListErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
        }
      },

      builder: (context, state) {
        var cubit = ProductCubit.get(context);
        if (cubit.wishListModel == null || state is ProductLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (cubit.wishListModel!.data!.data!.isEmpty) {
          return Center(
            child: Text('No Items in WishList'),
          );
        }
        return SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),



              SizedBox(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: MediaQuery
                    .of(context)
                    .size
                    .height ,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: cubit.wishListModel!.data!.data!.length,
                  itemExtent: 200,
                  addAutomaticKeepAlives: true,
                  addRepaintBoundaries: true,
                  addSemanticIndexes: true,

                  itemBuilder: (context, index) =>
                      BooksContainer(

                        image: cubit.wishListModel!.data!.data![index].image,
                        name: cubit.wishListModel!.data!.data![index].name,
                        price: cubit
                            .wishListModel!.data!.data![index].price
                            .toString(),
                        discount: cubit
                            .wishListModel!.data!.data![index].discount
                            .toString(),
                        category: cubit
                            .wishListModel!.data!.data![index].category,
                        priceNow: cubit
                            .wishListModel!.data!.data![index].price
                            .toString(),
                        stock: cubit.wishListModel!.data!.data![index].stock,
                        onPressed: () async {
                          await  CartCubit.get(context).addToCartData(
                            id: cubit.wishListModel!.data!.data![index].id!.toInt(),
                          );
                        },
                        onWishList: () async {
                          await cubit.deleteFromWishListData(
                            id: cubit.wishListModel!.data!.data![index].id!.toInt(),
                          );
                        },
                         icon: Icons.favorite,




                      ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
