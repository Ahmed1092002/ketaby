import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketaby/blocs/CartCubit/cart_cubit.dart';
import 'package:ketaby/blocs/ProductCubit/product_cubit.dart';
import 'package:ketaby/widgets/books_container.dart';

class BooksBody extends StatefulWidget {
  const BooksBody({Key? key}) : super(key: key);

  @override
  State<BooksBody> createState() => _BooksBodyState();
}

class _BooksBodyState extends State<BooksBody> {
  @override
  void initState() {
    // TODO: implement initState
    ProductCubit.get(context).getProductData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductState>(
      listener: (context, state) {
       if (state is ProductSuccessState) {
          print('success');
        }
        if (state is ProductErrorState) {
         ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
        }
      },

      builder: (context, state) {
        var cubit = ProductCubit.get(context);
    if (cubit.productModel == null || state is ProductLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
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
                  itemCount: 10,
                  itemExtent: 200,
                  addAutomaticKeepAlives: true,
                  addRepaintBoundaries: true,
                  addSemanticIndexes: true,

                  itemBuilder: (context, index) =>
                      BooksContainer(

                    image: cubit.productModel!.data!.products![index].image,
                    name: cubit.productModel!.data!.products![index].name,
                    price: cubit
                        .productModel!.data!.products![index].price
                        .toString(),
                    discount: cubit
                        .productModel!.data!.products![index].discount
                        .toString(),
                    category: cubit
                        .productModel!.data!.products![index].category,
                    priceNow: cubit
                        .productModel!.data!.products![index].priceAfterDiscount
                        .toString(),
                    stock: cubit.productModel!.data!.products![index].stock,
                    onPressed: () async {
                    await  CartCubit.get(context).addToCartData(
                        id: cubit.productModel!.data!.products![index].id!.toInt(),
                      );
                    },



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
