import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubmitButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  const SubmitButton(
      {Key key,
        this.onPressed,
        this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.size.width / 1.4,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.white),
      child: MaterialButton(
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
