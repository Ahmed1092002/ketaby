import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketaby/src/app_root.dart';

import '../blocs/HomePageCubit/home_page_cubit.dart';

class ProductMainScreanContainer extends StatelessWidget {
  String? image;
  String? name;
  String? price;
  int? discount;
  String? Category;
  String? priceAfterDiscount ;
   ProductMainScreanContainer({
    super.key,
    this.image,
    this.name,
    this.price,
    this.discount,
    this.Category,
     this.priceAfterDiscount
  });


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 210,
      child: Column(
        children: [
          Container(
              width: 150,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(
                      image!,),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    width: 50,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: mainColor,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "${discount}%",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ),
                ),
              )),
          Text(name!),
          Text(Category!,style: TextStyle(color: Colors.grey),),
          Text(price!,style: TextStyle(decoration: TextDecoration.lineThrough,color: Colors.grey),),
          Text(priceAfterDiscount!
            ,style: TextStyle(color: mainColor),
          ),
        ],
      ),
    );
  }
}
