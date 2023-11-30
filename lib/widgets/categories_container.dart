import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketaby/widgets/product_main_screan_container.dart';
import 'package:ketaby/widgets/title_of_componant_row.dart';

import '../blocs/HomePageCubit/home_page_cubit.dart';

class CategoriesContainer extends StatelessWidget {
  String? name;
   CategoriesContainer({
    super.key,
    this.name, });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage('assets/images/WhatsAppImage.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          width: 150,
          height: 150,
          color: Colors.black.withOpacity(0.5),
          alignment: Alignment.center,
          child: Text(
            name!,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
