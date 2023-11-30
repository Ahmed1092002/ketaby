import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ketaby/src/app_root.dart';

class CheckOutScreanTextFormField extends StatelessWidget {
  TextEditingController? controller = TextEditingController();
  String? hint;
  IconData? icon;


   CheckOutScreanTextFormField({
    super.key,
    this.controller,
    this.hint,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        controller: controller,

        style: TextStyle(
          color: Colors.black,
        ),

        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),

          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          isDense: true,
          isCollapsed: true,




          prefixIcon: Icon(icon),
          prefixIconColor: mainColor,
          label: Text(hint!),
          labelStyle: TextStyle(
            color: mainColor,
          ),

        ),
      ),
    );
  }
}
