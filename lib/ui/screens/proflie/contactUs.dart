import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qasimati/controller/AuthController.dart';
import 'package:qasimati/ui/widgets/CustomButton.dart';
import 'package:qasimati/ui/widgets/CustomTextFeild.dart';

// ignore: must_be_immutable
class ContactUs extends StatelessWidget {
  var controller = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        centerTitle: true,

        title: Text(
          "Contact us".tr,
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
              color: Colors.white,
              size: 24,
            )),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 5.h),
        child: ListView(
          children: [
            GetBuilder<AuthController>(builder: (_) {
              return Form(
                key: controller.contactForm,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(

                        // changes position of shadow
                        ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextFeild(
                            'Name'.tr, controller.nameController, 'Name'.tr),
                        SizedBox(
                          height: 10.h,
                        ),
                        CustomTextFeild('Email'.tr, controller.emailController,
                            'example@mail.com'),
                        SizedBox(
                          height: 10.h,
                        ),
                        Container(
                          child: CustomTextFeild('Subject'.tr,
                              controller.subjectController, 'Subject'.tr),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        CustomTextFeild('SubjectDes'.tr,
                            controller.bodyController, 'SubjectDes'.tr),
                        SizedBox(
                          height: 10.h,
                        ),
                        Container(
                            width: 360.w,
                            height: 46.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30)),
                            child: CustomButton("SEND".tr, () {
                              controller.contactUs();
                            }, Theme.of(context).primaryColor, Colors.white)),
                        SizedBox(
                          height: 10.h,
                        ),
                        Container(
                            width: 360.w,
                            height: 46.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30)),
                            child: CustomButton("CANCEL".tr, () {
                              Get.back();
                              controller.emailController.clear();
                              controller.passwordCotroller.clear();
                              controller.nameController.clear();
                            }, Colors.white, Colors.black)),
                        SizedBox(
                          height: 10.h,
                        ),
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
