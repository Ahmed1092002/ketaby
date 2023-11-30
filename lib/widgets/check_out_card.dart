import 'package:flutter/material.dart';
import 'package:ketaby/src/app_root.dart';

class CheckOutCard extends StatelessWidget {
  String ? totalPrice;
  String ? lapel;
  VoidCallback? onPressed;
   CheckOutCard({
    super.key,
    this.totalPrice,
    this.onPressed,
    this.lapel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: mainColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text('Total Price :',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              Text('$totalPrice',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              Text('L.E',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              Spacer(),
              ElevatedButton(
                  onPressed: onPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    fixedSize: Size(150, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                  child: Text(lapel!,
                      style: TextStyle(
                          color: mainColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)))
            ],
          ),
        ),
      ),
    );
  }
}
