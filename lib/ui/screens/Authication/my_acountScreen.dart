import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:qasimati/controller/AuthController.dart';
import 'package:qasimati/ui/screens/Authication/editScreen.dart';
import 'package:qasimati/ui/screens/proflie/favoriteScreen.dart';
import 'package:qasimati/ui/screens/home/home_screen.dart';

class MyAccount extends StatefulWidget {
  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  var controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<AuthController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
        leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(Icons.arrow_back_ios)),
        title: Text(
          "My Account".tr,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
      body: GetBuilder<AuthController>(builder: (controller) {
        return Container(
          child: Column(
            children: [
              controller.verify == "A"
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width / .2,
                        child: Row(
                          children: [
                            Icon(Icons.error, color: GFColors.DANGER),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Text('verifiy'.tr,
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 11.sp)),
                            ),
                            TextButton(
                                onPressed: () {
                                  controller.verifiyEmail();
                                },
                                child: Text("Send it again".tr,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12.sp,
                                      decoration: TextDecoration.underline,
                                    ))),
                          ],
                        ),
                      ),
                    )
                  : Container(),
              ListTile(
                onTap: () {
                  Get.to(EditScreen());
                },
                leading: Container(
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 28,
                      right: MediaQuery.of(context).size.width / 24),
                  child: SvgPicture.asset(
                    'assets/images/Profile.svg',
                    width: 24.w,
                    height: 30.h,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text('Edit Account'.tr,
                    style: TextStyle(
                        fontSize: 18.sp, fontWeight: FontWeight.w600)),
                contentPadding: EdgeInsets.only(top: 10),
                subtitle: Divider(
                  height: 10.h,
                  indent: 0,
                  endIndent: 30,
                  color: Colors.black,
                ),
              ),
              ListTile(
                onTap: () {
                  Get.to(Favourite());
                },
                leading: Container(
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 28,
                      right: MediaQuery.of(context).size.width / 24),
                  child: SvgPicture.asset(
                    "assets/images/Star.svg",
                    color: Color(0xff8A5EA4),
                    width: 24.w,
                    height: 30.h,
                  ),
                ),
                title: Text('Favourite'.tr,
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                contentPadding: EdgeInsets.symmetric(vertical: 0),
                subtitle: Divider(
                  height: 10.h,
                  indent: 0,
                  endIndent: 30,
                  color: Colors.black,
                ),
              ),
              ListTile(
                onTap: () {
                  controller.removeToken();
                  Get.offAll(HomeScreen());
                },
                leading: Container(
                  margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 28,
                      right: MediaQuery.of(context).size.width / 24),
                  child: SvgPicture.asset(
                    "assets/images/Iconly-Light-Logout.svg",
                    color: Color(0xff8A5EA4),
                    width: 24.w,
                    height: 30.h,
                  ),
                ),
                title: Text('Log Out'.tr,
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                contentPadding: EdgeInsets.symmetric(vertical: 0),
                subtitle: Divider(
                  height: 10.h,
                  indent: 0,
                  endIndent: 30,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
