import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketaby/Views/main_screan.dart';
import 'package:ketaby/src/cashe_helper.dart';
import 'package:ketaby/utils/navigator.dart';
import 'package:ketaby/widgets/check_out_screan_dropdown_button_form_field.dart';
import 'package:ketaby/widgets/check_out_screan_row.dart';
import 'package:ketaby/widgets/check_out_card.dart';
import 'package:ketaby/widgets/check_out_screan_text_form_field.dart';

import '../blocs/ChekoutCubit/check_out_cubit.dart';

class CheckOutScrean extends StatelessWidget {
  CheckOutScrean({Key? key}) : super(key: key);

  List<String> city = [
    'Cairo',
    'Alexandria',
    'Giza',
    'Dakahlia',
    'Aswan',
    'Asyut',
    'Beheira',
    'Beni Suef',
    'Faiyum',
    'Gharbia',
    'Giza',
    'Ismailia',
    'Kafr El Sheikh',
    'Matruh',
    'Minya',
    'Monufia',
    'New Valley',
    'Port Said',
    'Sharm El Sheikh',
    'Sohag',
    'Suez',
    'Tanta',
    'Tarom',
    'Qena',
    'Luxor',
    'Qalyubia',
    'North Sinai',
    'South Sinai',
    'El Wadi El Gedid',
    'Aswan',
  ];

  String? cityName;

getCityName(String? name){
  cityName=name;
}

String cityindex='';

getCityIndex(String index){
  cityindex=index;
}

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CheckOutCubit()..getCheckOutData(),
      child: BlocConsumer<CheckOutCubit, CheckOutState>(
        listener: (context, state) {
         if (state is PlaceOrderSucessState) {

           navigateToScreenAndExit(context, MainScrean(

           ));
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );



         }
          if (state is PlaceOrderFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red,
              ),
            );
          }
          if (state is CheckOutErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red,
              ),
            );
          }
          if (state is CheckOutSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('success'),
                backgroundColor: Colors.green,
              ),
            );
            CheckOutCubit.get(context).nameController.text=CheckOutCubit.get(context).checkOutModel!.data!.user!.userName.toString();
            CheckOutCubit.get(context).phoneController.text=CheckOutCubit.get(context).checkOutModel!.data!.user!.phone.toString()=='null'?'':CheckOutCubit.get(context).checkOutModel!.data!.user!.phone.toString();
            CheckOutCubit.get(context).addressController.text=CheckOutCubit.get(context).checkOutModel!.data!.user!.address.toString()=='null'?'':CheckOutCubit.get(context).checkOutModel!.data!.user!.address.toString();
            CheckOutCubit.get(context).emailController.text=CheckOutCubit.get(context).checkOutModel!.data!.user!.userEmail.toString();
          }
          if (state is PlaceOrderFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red,
              ),
            );


          }
        },
        builder: (context, state) {
          var cubit = CheckOutCubit.get(context);
          if (cubit.checkOutModel == null ) {
            return
              Scaffold(
                body: Center(
                  child: CircularProgressIndicator(

                  ),
                ),
              );

          }
          if (cubit.checkOutModel!.message =='Not Found' ) {
            return Center(
              child: Text('Not Found'),
            );
          }


          return Scaffold(
            body: SingleChildScrollView(
              physics: MediaQuery.of(context).viewInsets.bottom == 0
                  ? NeverScrollableScrollPhysics()
                  : BouncingScrollPhysics(),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).viewInsets.bottom == 0
                      ? MediaQuery.of(context).size.height
                      : MediaQuery.of(context).size.height * 0.9,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      CheckOutScreanTextFormField(
                        hint: 'Name',
                        icon: Icons.person,
                        controller: cubit.nameController,
                      ),
                      CheckOutScreanTextFormField(
                        hint: 'Email',
                        icon: Icons.email,
                        controller: cubit.emailController,),
                      CheckOutScreanTextFormField(
                        hint: 'Phone',
                        icon: Icons.phone,
                        controller: cubit.phoneController,),

                      CheckOutScreanTextFormField(
                        hint: 'Address',
                        icon: Icons.location_on,
                        controller: cubit.addressController,),
                      CheckOutScreanDropdownButtonFormField(city: city
                      ,onChanged: (value,index){
                        print (index);
                        getCityIndex(index.toString());
                        print (value);
                          getCityName(value);
                          print(cityName);
                      },
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: 1,
                        endIndent: 0,
                        indent: 0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 2.5,
                        child: ListView.separated(
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) =>
                              CheckOutScreanRow(
                              quantity: cubit.checkOutModel!.data!.cartItems![index].itemQuantity.toString(),
                              itemName: cubit.checkOutModel!.data!.cartItems![index].itemProductName.toString(),
                                price: cubit.checkOutModel!.data!.cartItems![index].itemTotal.toString()
                              ),
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 10),
                          itemCount: cubit.checkOutModel!.data!.cartItems!.length,
                        ),
                      ),
                      Flexible(
                        child: CheckOutCard(
                          lapel: 'order now',
                          totalPrice: cubit.checkOutModel!.data!.total.toString(),
                          onPressed: () async {
                            cubit.placeOrder(governorate_id: cityindex.toString());

                          },
                        ),
                      ),
                    ],
                  )),
            ),
          );
        },
      ),
    );
  }
}
