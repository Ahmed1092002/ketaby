import 'package:flutter/material.dart';

class CheckOutScreanRow extends StatelessWidget {
  String? itemName;
  String? quantity;
  String? price;

   CheckOutScreanRow({
    super.key,
    required this.itemName,
    required this.quantity,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  itemName!,

                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  'Quantity: $quantity',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            '\$ $price',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
