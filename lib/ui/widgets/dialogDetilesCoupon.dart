import 'package:clipboard/clipboard.dart';
import 'package:dashed_container/dashed_container.dart';
import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:qasimati/controller/ApiController.dart';
import 'package:qasimati/models/coupon.dart';
import 'package:qasimati/ui/screens/webView/webView.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class DetialsCoupon extends StatefulWidget {
  CouponModel couponModel;
  DetialsCoupon({this.couponModel});
  @override
  _DetialsCouponState createState() => _DetialsCouponState();
}

class _DetialsCouponState extends State<DetialsCoupon>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;
  ApiController controller;

  void launchURL() async {
    await canLaunch(widget.couponModel.link)
        ? await launch(widget.couponModel.link)
        : throw Get.to((OfferPage(widget.couponModel.link)));
  }

  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  bool iscopy = false;
  bool isFavaiort = false;
  bool isvaild = false;
  bool isNotvaild = false;
  @override
  void initState() {
    isFavaiort = widget.couponModel.isFavaiort == "true" ? true : false;
    controller = Get.find<ApiController>();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(animationController)
      ..addListener(() {
        setState(() {});
      });
    animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: animation.value,
      child: GetBuilder<ApiController>(builder: (controller) {
        return Container(
          child: AlertDialog(
            scrollable: true,
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(MediaQuery.of(context).size.width / 17),
            ),
            content: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Container(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        child: SvgPicture.asset(
                            !isFavaiort
                                ? "assets/images/Star.svg"
                                : "assets/images/Group 14465.svg",
                            width: 24.w,
                            height: 24.h,
                            color: Theme.of(context).primaryColor),
                        onTap: () {
                          isFavaiort = !isFavaiort;
                          if (isFavaiort == true) {
                            controller.addFavavrite(
                                widget.couponModel.id, context);
                          }
                          if (isFavaiort == false) {
                            controller.deleteFavavrite(widget.couponModel.id);
                          }
                          setState(() {});
                        },
                      ),
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width / 25,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                                color: Colors.black.withOpacity(.3))),
                        padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.width / 18,
                            horizontal: MediaQuery.of(context).size.width / 30),
                        width: MediaQuery.of(context).size.width / 3,
                        child: Image(
                          image: NetworkImage(
                            widget.couponModel.store.image,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  widget.couponModel.store.name,
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                  width: 160.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      launchURL();
                    },
                    child: Container(
                      height: 50.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Theme.of(context).primaryColor),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Visit".tr,
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            width: 5.h,
                          ),
                          Icon(
                            Icons.link_outlined,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                FDottedLine(
                  color: Colors.grey.shade200,
                  width: MediaQuery.of(context).size.width / 1.4,
                  strokeWidth: 2.0,
                  dottedLength: 6.0,
                  space: 2.0,
                ),
                // Container(
                //   child: DottedLine(
                //     direction: Axis.horizontal,
                //   ),
                // ),
                Column(
                  children: [
                    Text(
                      "offer".tr,
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.w500),
                    ),
                    Text(widget.couponModel.mainTitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.grey,
                        )),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Column(
                  children: [
                    Text(
                      "Details".tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(widget.couponModel.description,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey,
                        )),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                FDottedLine(
                  color: Colors.grey.shade200,
                  width: MediaQuery.of(context).size.width / 1.4,
                  strokeWidth: 2.0,
                  dottedLength: 6.0,
                  space: 2.0,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Last Valid use:".tr,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14.sp),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      widget.couponModel.enable,
                      style: TextStyle(
                          fontSize: 14.sp,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                GestureDetector(
                  onTap: () {
                    FlutterClipboard.copy(widget.couponModel.code)
                        .then((value) => print(widget.couponModel.code));
                    controller.toggle();
                  },
                  child: controller.iscopy == false
                      ? DashedContainer(
                          borderRadius: 20.w,
                          dashColor: Theme.of(context).primaryColor,
                          child: Container(
                            height: 50.h,
                            width: MediaQuery.of(context).size.width / 2,
                            decoration: BoxDecoration(
                                color: Color(0xffF5F3FF).withOpacity(.7),
                                borderRadius: BorderRadius.circular(20.w)),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Container(
                                    child: Center(
                                      child: Text(widget.couponModel.code,
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              color: Theme.of(context)
                                                  .primaryColor)),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Get.locale.toString() == 'ar'
                                            ? Radius.circular(20)
                                            : Radius.zero,
                                        bottomLeft:
                                            Get.locale.toString() == 'ar'
                                                ? Radius.circular(20)
                                                : Radius.zero,
                                        topRight: Get.locale.toString() == 'en'
                                            ? Radius.circular(20)
                                            : Radius.zero,
                                        bottomRight:
                                            Get.locale.toString() == 'en'
                                                ? Radius.circular(20)
                                                : Radius.zero,
                                      ),
                                    ),
                                    height: 50.h,
                                    child: Center(
                                        child: Text(
                                      "Copy Code".tr,
                                      style: TextStyle(
                                          fontSize: 16.sp, color: Colors.white),
                                    )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : DashedContainer(
                          borderRadius: 20.w,
                          dashColor: Theme.of(context).primaryColor,
                          child: Container(
                            height: 50.h,
                            width: MediaQuery.of(context).size.width / 2,
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(20.w)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  width: MediaQuery.of(context).size.width / 3,
                                  height: 50.h,
                                  child: Center(
                                      child: Text(
                                    "COPIED".tr,
                                    style: TextStyle(
                                        fontSize: 16.sp, color: Colors.white),
                                  )),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 6,
                                  child: Center(
                                    child:
                                        Icon(Icons.done, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  child: Column(
                    children: [
                      Text('Does'.tr),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              isvaild = !isvaild;
                              if (isvaild) {
                                isNotvaild = false;
                                controller.voteCoupon(
                                    'enable', widget.couponModel.id);
                                controller.getAllCouponInStore();
                                controller.getCouponsByCategory(
                                    controller.selectCategoryName);
                              }
                              setState(() {});
                            },
                            child: FaIcon(
                              isvaild
                                  ? Icons.thumb_up
                                  : Icons.thumb_up_outlined,
                              color: Theme.of(context).primaryColor,
                              size: MediaQuery.of(context).size.width / 13,
                            ),
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.voteCoupon(
                                  'disable', widget.couponModel.id);
                              isNotvaild = !isNotvaild;

                              if (isNotvaild) {
                                isvaild = false;
                              } else {
                                isvaild = true;
                              }

                              setState(() {});
                            },
                            child: FaIcon(
                              !isNotvaild
                                  ? Icons.thumb_down_outlined
                                  : Icons.thumb_down,
                              color: Theme.of(context).primaryColor,
                              size: MediaQuery.of(context).size.width / 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
