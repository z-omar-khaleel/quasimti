import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  String label;
  Function onTap;
  Color color;
  Color colorText;
  CustomButton(this.label, this.onTap, this.color, this.colorText);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(color),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ))),
      onPressed: onTap,
      child: Text(
        label,
        style: TextStyle(fontSize: 16.sp, color: colorText),
      ),
    );
  }
}
