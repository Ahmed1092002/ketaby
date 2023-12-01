import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketaby/blocs/ProfileCubit/profile_cubit.dart';

import '../blocs/OrderHistory/order_history_cubit.dart';

class OrderHistoryScrean extends StatelessWidget {
  const OrderHistoryScrean({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderHistoryCubit()..getOrderData(),
      child: BlocConsumer<OrderHistoryCubit, OrderHistoryState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = OrderHistoryCubit.get(context);
          // if (cubit.noOrderHistoryModel != null) {
          //   return Scaffold(
          //     appBar: AppBar(
          //       title: Text('Order History'),
          //       centerTitle: true,
          //       backgroundColor: Colors.white,
          //       elevation: 0,
          //     ),
          //     body: Center(
          //       child: Text(
          //         'No Orders To Show',
          //         style: TextStyle(fontSize: 20),
          //       ),
          //     ),
          //   );
          // }

          if (cubit.orderHistoryModel == null) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Order History'),
                centerTitle: true,
                backgroundColor: Colors.white,
                elevation: 0,
              ),
              body: Center(
                child: Text('non'),
              ),
            );  }


          // if (cubit.orderHistoryModel!.data==null) {
          //   return Scaffold(
          //     appBar: AppBar(
          //       title: Text('Order History'),
          //       centerTitle: true,
          //       backgroundColor: Colors.white,
          //       elevation: 0,
          //     ),
          //     body: Center(
          //       child: Text(
          //         'No Orders To Show',
          //         style: TextStyle(fontSize: 20),
          //       ),
          //     ),
          //   );
          // }


    return  Scaffold(
      appBar: AppBar(
        title: Text(
            'Order History- total orders ${cubit.orderHistoryModel!.data!.orders!.length}'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.separated(
        itemCount: cubit.orderHistoryModel!.data!.orders!.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order Number:${cubit.orderHistoryModel!.data!.orders![index].orderCode}',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      'Order Status:${cubit.orderHistoryModel!.data!.orders![index].status}',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      'Total Price:${cubit.orderHistoryModel!.data!.orders![index].total}L.E',
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
                Text(
                  'Order Date\n${cubit.orderHistoryModel!.data!.orders![index].orderDate}',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        ),
        separatorBuilder: (context, index) => Divider(),
      ),
    );

        },
      ),
    );
  }
}
