import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qasimati/controller/AuthController.dart';
import 'package:qasimati/ui/widgets/CustomButton.dart';
import 'package:qasimati/ui/widgets/CustomTextFeild.dart';

// ignore: must_be_immutable
class ForgetPassword extends StatelessWidget {
  var controller = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_forward_ios),
            onPressed: () {
              Get.back();
            },
          ),
        ],
        title: Text(
          "ForgetPassword".tr,
          style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Theme.of(context).primaryColor,
              size: 24,
            )),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: ListView(
          children: [
            GetBuilder<AuthController>(builder: (controller) {
              return Form(
                key: controller.forgetKey,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(

                        // changes position of shadow
                        ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Image.asset(
                            'assets/images/Logo.png',
                            width: 200.w,
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Text(
                          "Please".tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16.sp),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        CustomTextFeild('Email'.tr, controller.emailController,
                            'example@mail.com'),
                        SizedBox(
                          height: 30.h,
                        ),
                        Container(
                            width: 350.w,
                            height: 46.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30)),
                            child: CustomButton("Send".tr, () {
                              controller.forgetPassword();
                              // Get.off(Login());
                            }, Theme.of(context).primaryColor, Colors.white)),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
