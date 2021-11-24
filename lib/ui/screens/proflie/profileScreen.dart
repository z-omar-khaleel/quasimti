import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/appbar/gf_appbar.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/getwidget.dart';
import 'package:qasimati/controller/ApiController.dart';
import 'package:qasimati/controller/AuthController.dart';
import 'package:qasimati/controller/appLanguage.dart';
import 'package:qasimati/ui/screens/AddProduct/AddProduchSccreen.dart';
import 'package:qasimati/ui/screens/Authication/LoginScreen.dart';
import 'package:get/get.dart';
import 'package:qasimati/ui/screens/proflie/favoriteScreen.dart';
import 'package:qasimati/ui/screens/Authication/my_acountScreen.dart';
import 'package:qasimati/ui/screens/Authication/signUpScreen.dart';
import 'package:qasimati/ui/screens/proflie/aboutUs.dart';
import 'package:qasimati/ui/screens/proflie/contactUs.dart';
import 'package:qasimati/ui/screens/proflie/privacy.dart';
import 'package:qasimati/ui/screens/proflie/questions.dart';
import 'package:qasimati/ui/screens/proflie/termsConditions.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool toggleValue = false;
  int inial;

  AuthController controller;
  AppLanguage controller1;
  ApiController controller2;
  @override
  void initState() {
    controller = Get.find<AuthController>();
    controller1 = Get.find<AppLanguage>();
    controller2 = Get.find<ApiController>();
    controller.getUser();
    controller.getToken();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GFAppBar(
        title: Text(
          "Profile".tr,
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: GetBuilder<AuthController>(
        init: AuthController(),
        builder: (controller) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  controller.name == null
                      ? Container(
                          margin: EdgeInsets.only(top: 30.h, bottom: 10.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.to(SignUp());
                                },
                                child: Container(
                                  child: Column(
                                    children: [
                                      GFAvatar(
                                          backgroundColor: Theme.of(context)
                                              .primaryColor
                                              .withOpacity(.1),
                                          foregroundColor:
                                              Theme.of(context).primaryColor,
                                          size: 55.w,
                                          child: SvgPicture.asset(
                                            'assets/images/Add User.svg',
                                            width: 24.w,
                                            height: 24.h,
                                          )),
                                      Text(
                                        "Sign Up".tr,
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(Login());
                                },
                                child: Container(
                                  child: Column(
                                    children: [
                                      GFAvatar(
                                          backgroundColor: Theme.of(context)
                                              .primaryColor
                                              .withOpacity(.1),
                                          foregroundColor:
                                              Theme.of(context).primaryColor,
                                          size: 55.w,
                                          child: SvgPicture.asset(
                                            'assets/images/Iconly-Light-Profile.svg',
                                            width: 24.w,
                                            height: 24.h,
                                            fit: BoxFit.cover,
                                          )),
                                      Text(
                                        "Sign In".tr,
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            Get.to(MyAccount());
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 30.h, bottom: 10.h),
                            child: Column(
                              children: [
                                GFAvatar(
                                  backgroundColor: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(.1),
                                  foregroundColor:
                                      Theme.of(context).primaryColor,
                                  size: 55.w,
                                  child: SvgPicture.asset(
                                    'assets/images/Profile.svg',
                                    width: 24.w,
                                    height: 24.h,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Text(
                                  controller.name,
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                        ),
                  Container(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (controller.name == null) {
                              Get.defaultDialog(
                                title: "Sorry".tr,
                                titleStyle: TextStyle(color: Colors.black87),
                                content: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Content".tr,
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            color: Colors.grey),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          19,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(15.w)),
                                          child: TextButton(
                                              onPressed: () {
                                                Get.off(Login());
                                              },
                                              child: Text(
                                                "Sign In".tr,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: TextButton(
                                              onPressed: () {
                                                Get.off(SignUp());
                                              },
                                              child: Text(
                                                "Sign Up".tr,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            } else if (controller.verify == "A") {
                              Get.snackbar(
                                  'Sorry'.tr, "Check your verify account".tr);
                            } else if (controller.name != null &&
                                controller.verify != "A") {
                              controller.getUser();
                              Get.to(AddCoubon());
                            }
                          },
                          child: Container(
                              child: ListTile(
                            leading: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.w),
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(.1)),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: SvgPicture.asset(
                                  "assets/images/Iconly-Light-Ticket.svg",
                                  width: 24.w,
                                  height: 24.h,
                                  color: Color(0xff8A5EA4),
                                ),
                              ),
                            ),
                            title: Text(
                              "Add Coupon".tr,
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.black,
                                  fontFamily: 'Jannat',
                                  fontWeight: FontWeight.bold),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios),
                          )),
                        ),
                        Divider(),
                        GetBuilder<AppLanguage>(builder: (contrller1) {
                          return Container(
                              child: ListTile(
                            leading: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.w),
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(.1)),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SvgPicture.asset(
                                  "assets/images/global.svg",
                                  width: 24.w,
                                  height: 24.h,
                                  color: Color(0xff8A5EA4),
                                ),
                              ),
                            ),
                            title: Row(
                              children: [
                                Text(
                                  "Language".tr,
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: Get.locale.toString() == "en"
                                      ? 40.w
                                      : 80.w,
                                ),
                                ToggleSwitch(
                                  changeOnTap: false,
                                  minWidth: 90.0.w,
                                  minHeight: 50.h,
                                  initialLabelIndex: controller1.inial ?? 0,
                                  cornerRadius: 30.0,
                                  activeFgColor: Colors.white,
                                  inactiveBgColor: Colors.white,
                                  inactiveFgColor: Colors.black,
                                  totalSwitches: 2,
                                  radiusStyle: true,
                                  labels: ['العربية', 'English'],
                                  fontSize: 15.sp,
                                  activeBgColors: [
                                    [Theme.of(context).primaryColor],
                                    [Theme.of(context).primaryColor],
                                  ],
                                  onToggle: (index) {
                                    if (index == 1) {
                                      controller1.inial = 1;
                                      controller1.changeLanguage("en");
                                      Get.updateLocale(Locale("en"));
                                      controller2.getCategories();
                                      controller2.getAllCouponInStore();
                                      controller2.getCouponsByCategory(
                                          controller2.selectCategoryName);
                                    } else if (index == 0) {
                                      controller1.inial = 0;
                                      controller1.changeLanguage("ar");
                                      Get.updateLocale(Locale("ar"));
                                      controller2.getCategories();
                                      controller2.getAllCouponInStore();
                                      controller2.getCouponsByCategory(
                                          controller2.selectCategoryName);
                                    }
                                  },
                                ),
                              ],
                            ),
                          ));
                        }),
                        Divider(),
                        GestureDetector(
                          onTap: () {
                            if (controller.name == null) {
                              Get.defaultDialog(
                                title: "Sorry".tr,
                                titleStyle: TextStyle(color: Colors.black87),
                                content: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "You can add coupons to your favourite when you log in"
                                            .tr,
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            color: Colors.black54),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          19,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(15.w)),
                                          child: TextButton(
                                              onPressed: () {
                                                Get.off(Login());
                                              },
                                              child: Text(
                                                "Sign In".tr,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: TextButton(
                                              onPressed: () {
                                                Get.off(SignUp());
                                              },
                                              child: Text(
                                                "Sign Up".tr,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              Get.to(Favourite());
                            }
                          },
                          child: Container(
                              child: ListTile(
                            leading: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.w),
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(.1)),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SvgPicture.asset(
                                  "assets/images/Star.svg",
                                  color: Color(0xff8A5EA4),
                                  width: 24.w,
                                  height: 24.h,
                                ),
                              ),
                            ),
                            title: Text(
                              "Favourite".tr,
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios),
                          )),
                        ),
                        Divider(),
                        GestureDetector(
                          onTap: () {
                            Get.to(AboutUs());
                          },
                          child: Container(
                              child: ListTile(
                            leading: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.w),
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(.1)),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SvgPicture.asset(
                                  "assets/images/Home-icon.svg",
                                  color: Color(0xff8A5EA4),
                                  width: 24.w,
                                  height: 24.h,
                                ),
                              ),
                            ),
                            title: Text(
                              "About us".tr,
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios),
                          )),
                        ),
                        Divider(),
                        GestureDetector(
                          onTap: () {
                            Get.to(ContactUs());
                          },
                          child: Container(
                              child: ListTile(
                            leading: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.w),
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(.1)),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SvgPicture.asset(
                                  "assets/images/Iconly-Light-Message.svg",
                                  color: Color(0xff8A5EA4),
                                  width: 24.w,
                                  height: 24.h,
                                ),
                              ),
                            ),
                            title: Text(
                              "Contact us".tr,
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios),
                          )),
                        ),
                        Divider(),
                        GestureDetector(
                          onTap: () {
                            Get.to(Questions());
                          },
                          child: Container(
                              child: ListTile(
                            leading: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.w),
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(.1)),
                              child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: FaIcon(
                                    Icons.info_outline,
                                    color: Color(0xff8A5EA4),
                                  )),
                            ),
                            title: Text(
                              "Common questions".tr,
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios),
                          )),
                        ),
                        Divider(),
                        GestureDetector(
                          onTap: () {
                            Get.to(TermsConditions());
                          },
                          child: Container(
                              child: ListTile(
                            leading: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.w),
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(.1)),
                              child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: SvgPicture.asset(
                                    "assets/images/Paper.svg",
                                    color: Color(0xff8A5EA4),
                                    width: 24.w,
                                    height: 24.h,
                                  )),
                            ),
                            title: Text(
                              "Terms & Conditions".tr,
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios),
                          )),
                        ),
                        Divider(),
                        GestureDetector(
                          onTap: () {
                            Get.to(Privacy());
                          },
                          child: Container(
                              child: ListTile(
                            leading: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.w),
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(.1)),
                              child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: SvgPicture.asset(
                                    "assets/images/Group 14455.svg",
                                    color: Color(0xff8A5EA4),
                                    width: 24.w,
                                    height: 24.h,
                                  )),
                            ),
                            title: Text(
                              "Privacy policy".tr,
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios),
                          )),
                        ),
                        SizedBox(
                          height: 20.h,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
