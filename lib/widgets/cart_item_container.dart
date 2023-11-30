import 'package:flutter/material.dart';
import 'package:ketaby/src/app_root.dart';

class CartItemContainer extends StatelessWidget {
  String? name;
  double? price;
  String? oldPrice;
  String ? image;
  int ? quantity;
VoidCallback? addItem;
VoidCallback? removeItem;
  Function()? removeProductFromCart;
  CartItemContainer({
    super.key,
    this.name,
    this.price,
    this.image,
    this.quantity,
    this.addItem,
    this.removeItem,
    this.oldPrice,
    this.removeProductFromCart,
  });










  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 170,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.grey[300]!,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 150,
                width: 130,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: NetworkImage(
                          image!,
                        ),
                        fit: BoxFit.cover)),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Flexible(
              flex: 10,
              child: SizedBox(
                width: 300,
                height: 150,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Flexible(
                      child: Text(
                        name!,
                        maxLines: 5,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 150,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[300],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(onPressed:addItem , icon: Icon(Icons.add)),
                          Text(
                            '$quantity',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                              onPressed: removeItem, icon: Icon(Icons.remove)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Spacer(),
            Column(
              children: [
                IconButton(
                  onPressed: removeProductFromCart,
                  icon: Icon(Icons.delete),
                  color: Colors.red,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  oldPrice.toString(),
                  style: TextStyle(
                      color: Colors.grey[500],
                      decoration: TextDecoration.lineThrough,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  price.toString(),
                  style: TextStyle(
                      color: mainColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
