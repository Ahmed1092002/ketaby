import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String?buttonName;
  final void Function()? onPressed;
  const  CustomButton({
    super.key,
    this.buttonName,
    this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: Theme.of(context).elevatedButtonTheme.style,
      child: Text(
        buttonName!,
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }
}