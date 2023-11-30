import 'package:flutter/material.dart';

class TitleOfComponantRow extends StatelessWidget {
  String? title;
   TitleOfComponantRow({
    super.key,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            title!,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_forward_ios),
          color: Colors.black,
        ),
      ],
    );
  }
}
