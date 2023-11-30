import 'package:flutter/material.dart';
import 'package:ketaby/src/app_root.dart';

class BooksContainer extends StatelessWidget {
  String? name;
  String? image;
  String? category;
  String? price;
  String? priceNow;
  String? discount;
  int ? stock;
   Function()? onPressed;

   BooksContainer({
    super.key,
    this.name,
    this.image,
    this.category,
    this.price,
    this.priceNow,
    this.discount,
    this.stock,
    this.onPressed,
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
                ),
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

                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      category!,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      price!,
                      style: TextStyle(
                          color: Colors.grey[500],
                          decoration: TextDecoration.lineThrough,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      priceNow!,
                      style: TextStyle(
                          color: mainColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            Column(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.favorite_border),
                ),
                Text(
                  "items in Stock\n ${stock.toString()}",
                  style: TextStyle(
                      color: Colors.grey[500],

                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),

                Spacer(),
                IconButton(
                  onPressed: onPressed ,
                  color: Colors.black,
                  icon: Icon(Icons.add_shopping_cart_outlined),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
