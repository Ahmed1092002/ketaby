import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketaby/src/cashe_helper.dart';
import 'package:ketaby/widgets/product_main_screan_container.dart';
import 'package:ketaby/widgets/categories_container.dart';
import 'package:ketaby/widgets/main_screan_drawer.dart';
import 'package:ketaby/widgets/title_of_componant_row.dart';

import '../blocs/HomePageCubit/home_page_cubit.dart';

class HomeBody extends StatefulWidget {

  HomeBody({Key? key, }) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  String? name;

  String? image;
  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
    HomePageCubit.get(context).getSliderData();
    HomePageCubit.get(context).getBestSellerData();
    HomePageCubit.get(context).getCategoryData();
    HomePageCubit.get(context).getNewAriavlData();
    // name = await CashHelper.getData(key: 'name').toString();
    // image = await CashHelper.getData(key: 'image').toString();

    initializeState();

  }
 Future  <void> initializeState() async {


    name = await CashHelper.getData(key: 'name').toString();

    image = await CashHelper.getData(key: 'image').toString();
  }


  @override
  Widget build(BuildContext context) {

    return BlocConsumer<HomePageCubit, HomePageState>(
      listener: (context, state) {
        if (state is GetSliderError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error'),
            ),
          );
        }
      },
      builder: (context, state) {

        var cubit = HomePageCubit.get(context);

        if (cubit.imageSliders.isEmpty ||
            cubit.bestSellerModel == null ||
            cubit.categoriesModel == null ||

            cubit.newArrivalModel == null||
            name == null ||
            image == null

        ) {
          return Center(child: CircularProgressIndicator());
        }
        return FutureBuilder(
            future: initializeState(),

            builder:(_,snapsot){
            if (snapsot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              return
                SingleChildScrollView(
                child: Column(children: [
                  SizedBox(
                    height: 10,
                  ),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    height: 100,
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                          icon: Icon(
                            Icons.menu,
                            size: 40,
                          ),
                          color: Colors.black,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (name == null || name == 'null')
                              CircularProgressIndicator()
                            else
                              Text(
                                name!,
                                style:
                                TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            SizedBox(height: 5),
                            Text(
                              'What Are You Looking today?',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                        Spacer(),
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: image == null
                              ? AssetImage('assets/images/WhatsAppImage.jpg')
                              : NetworkImage(image!) as ImageProvider,
                          child: image ==null || image == 'null' ? CircularProgressIndicator() :
                          Image.network(image !) ,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        child: CarouselSlider(
                          options: CarouselOptions(
                            autoPlay: true,
                            aspectRatio: 2.0,
                            enlargeCenterPage: true,
                          ),
                          items: cubit.imageSliders,
                        ),
                      ),
                      TitleOfComponantRow(
                        title: 'Best Seller',
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 370,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ProductMainScreanContainer(
                                  Category: cubit
                                      .bestSellerModel!.data!.products![index].category!,
                                  discount: cubit
                                      .bestSellerModel!.data!.products![index].discount,
                                  image:
                                  cubit.bestSellerModel!.data!.products![index].image!,
                                  name: cubit.bestSellerModel!.data!.products![index].name!,
                                  price: cubit.bestSellerModel!.data!.products![index].price
                                      .toString(),
                                  priceAfterDiscount: cubit.bestSellerModel!.data!
                                      .products![index].priceAfterDiscount
                                      .toString(),
                                ),
                              );
                            },
                            itemCount: cubit.bestSellerModel!.data!.products!.length),
                      ),
                      TitleOfComponantRow(
                        title: 'Categories',
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 150,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return CategoriesContainer(
                                name: cubit.categoriesModel!.data!.categories![index].name,
                              );
                            },
                            itemCount: cubit.categoriesModel!.data!.categories!.length),
                      ),
                      TitleOfComponantRow(
                        title: 'New Arrival',
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 400,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ProductMainScreanContainer(
                                  Category: cubit
                                      .newArrivalModel!.data!.products![index].category!,
                                  discount: cubit
                                      .newArrivalModel!.data!.products![index].discount,
                                  image:
                                  cubit.newArrivalModel!.data!.products![index].image!,
                                  name: cubit.newArrivalModel!.data!.products![index].name!,
                                  price: cubit.newArrivalModel!.data!.products![index].price
                                      .toString(),
                                  priceAfterDiscount: cubit.newArrivalModel!.data!
                                      .products![index].priceAfterDiscount
                                      .toString(),
                                ),
                              );
                            },
                            itemCount: cubit.bestSellerModel!.data!.products!.length),
                      ),
                    ],
                  )

                ])) ;
        }
        }

        );
      },
    );
  }
}
