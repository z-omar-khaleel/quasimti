import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

// ignore: must_be_immutable
class CustomTextFeild extends StatefulWidget {
  String label;
  String hint;
  bool isPassword;

  TextEditingController controller = TextEditingController();
  CustomTextFeild(this.label, this.controller, this.hint,
      [this.isPassword = false]);

  @override
  _CustomTextFeildState createState() => _CustomTextFeildState();
}

class _CustomTextFeildState extends State<CustomTextFeild> {
  bool isObscure = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp),
        ),
        SizedBox(
          height: 10.h,
        ),
        Container(
          height: widget.label == "SubjectDes".tr ? 150.h : 46.h,
          width: 500.w,
          child: TextFormField(
            maxLines: widget.label == "SubjectDes".tr ? 4 : 1,
            validator: (String v) {
              if (widget.hint == "example@mail.com") {
                if (!GetUtils.isEmail(v)) {
                  return "Eamil is not vaild".tr;
                }
              } else if (widget.hint == "********") {
                if (v.trim().length <= 6) {
                  return "Password must be greater than 6".tr;
                }
              } else if (widget.label == "Name".tr) {
                if ((v.trim().isEmpty)) {
                  return "Username is not Empty".tr;
                }
              }
              return null;
            },
            obscureText: widget.isPassword ? isObscure : false,
            controller: widget.controller,
            decoration: InputDecoration(
              errorMaxLines: 1,
              suffix: Visibility(
                visible: widget.isPassword,
                child: IconButton(
                  icon: isObscure
                      ? Icon(
                          Icons.visibility_off,
                        )
                      : Icon(Icons.remove_red_eye_outlined),
                  onPressed: () {
                    isObscure = !isObscure;
                    setState(() {});
                  },
                ),
              ),
              filled: true,
              fillColor: Colors.grey.shade100,
              hintText: widget.hint,
              contentPadding: EdgeInsets.only(
                  top: 10.h, right: 10.w, left: 10.w, bottom: 10.h),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFD1D8E5),
                ),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
