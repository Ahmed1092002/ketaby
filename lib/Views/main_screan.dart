import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ketaby/Views/books_body.dart';
import 'package:ketaby/blocs/ChangePasswordAndDeleteAccount/change_password_and_delete_account_cubit.dart';
import 'package:ketaby/widgets/main_screan_drawer.dart';
import 'package:ketaby/Views/profile_body.dart';
import 'package:ketaby/blocs/ChekoutCubit/check_out_cubit.dart';
import 'package:ketaby/blocs/HomePageCubit/home_page_cubit.dart';
import 'package:ketaby/blocs/ProductCubit/product_cubit.dart';
import 'package:ketaby/blocs/ProfileCubit/profile_cubit.dart';

import '../blocs/CartCubit/cart_cubit.dart';
import 'cart_body.dart';
import 'home_body.dart';

class MainScrean extends StatefulWidget {


  MainScrean({Key? key,

  }) : super(key: key);

  @override
  State<MainScrean> createState() => _MainScreanState();
}

class _MainScreanState extends State<MainScrean> {

  List <Widget> widgetList = [];

  @override
  void initState() {
    // TODO: implement initState



    widgetList = [
      HomeBody(

      ),
      BooksBody(),
      Text('Books'),
      CartBody(),
      ProfileBody(),


    ];


    super.initState();
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   _profileCubit = BlocProvider.of<ProfileCubit>(context); // Access ProfileCubit using BlocProvider.of()
  // }
  int selectedIndex = 0;

  handleWidgetList(index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              HomePageCubit(),
        ),
        BlocProvider(create: (context) => ProductCubit()),
        BlocProvider(create: (context) => CartCubit()),
        BlocProvider(create: (context) =>
        ProfileCubit()
          ..getProfileData()),

      ],
      child: Scaffold(
        drawer: MainScreanDrawer(
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            handleWidgetList(index);
          },


          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Books'),

            BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border), label: 'favorite'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined), label: 'cart'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),

        body: widgetList[selectedIndex],
      ),
    );
  }
}
