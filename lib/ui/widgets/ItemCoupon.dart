import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qasimati/controller/ApiController.dart';
import 'package:qasimati/models/coupon.dart';
import 'package:qasimati/ui/screens/webView/webView.dart';
import 'package:qasimati/ui/widgets/dialogDetilesCoupon.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class ItemCoupon extends StatefulWidget {
  CouponModel couponModel;

  ItemCoupon(this.couponModel);

  @override
  State<ItemCoupon> createState() => _ItemCouponState();
}

class _ItemCouponState extends State<ItemCoupon> {
  var controller;

  @override
  void initState() {
    controller = Get.find<ApiController>();
    super.initState();
  }

  void launchURL() async => await canLaunch(widget.couponModel.store.link)
      ? await launch(widget.couponModel.link)
      : throw Get.to((OfferPage(widget.couponModel.link)));

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16.h, right: 24.w, left: 24.w),
      height: 98.h,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(
            Get.locale.toString() == "ar"
                ? 'assets/images/background.png'
                : "assets/images/backgroundRight.png",
          ),
        ),
      ),
      child: GestureDetector(
        onTap: () {
          if (widget.couponModel.type == 'coupon') {
            showDialog(
                context: context,
                builder: (context) {
                  return Container(
                    height: MediaQuery.of(context).size.height / 2,
                    child: DetialsCoupon(
                      couponModel: widget.couponModel,
                    ),
                  );
                });
          } else {
            if (widget.couponModel.link != null) {
              launchURL();
            }
          }
        },
        child: Stack(
          children: [
            Align(
              alignment: Get.locale.toString() == "en"
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              child: Container(
                // width: MediaQuery.of(context).size.width/2,
                margin: EdgeInsets.only(
                    right: Get.locale.toString() == "ar"
                        ? MediaQuery.of(context).size.width * .03
                        : 0,
                    left: Get.locale.toString() == "en"
                        ? MediaQuery.of(context).size.width * .03
                        : 0),
                child: Image.network(
                  widget.couponModel.store.image,
                  width: MediaQuery.of(context).size.width / 5,
                ),
              ),
            ),
            Positioned(
              top: 10.h,
              right: Get.locale.toString() == "ar"
                  ? MediaQuery.of(context).size.width / 3.2
                  : MediaQuery.of(context).size.width / 9,
              left: Get.locale.toString() == "en"
                  ? MediaQuery.of(context).size.width / 3.2
                  : MediaQuery.of(context).size.width / 10,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  widget.couponModel.store.name,
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            widget.couponModel.tag.name != null
                ? Align(
                    alignment: Get.locale.toString() == "ar"
                        ? Alignment.topLeft
                        : Alignment.topRight,
                    child: Container(
                      height: 24.h,
                      margin: EdgeInsets.only(
                        top: 10.h,
                        right: Get.locale.toString() == "en" ? 10.w : 0,
                        left: Get.locale.toString() == "ar" ? 10.w : 0,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                      ),
                      child: Text(
                        widget.couponModel.tag.name,
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ),
                  )
                : Container(),
            Positioned(
              top: widget.couponModel.tag.name == null
                  ? MediaQuery.of(context).size.width / 12
                  : MediaQuery.of(context).size.width / 11.5,
              right: Get.locale.toString() == "ar"
                  ? MediaQuery.of(context).size.width / 3
                  : MediaQuery.of(context).size.width / 9,
              left: Get.locale.toString() == "en"
                  ? MediaQuery.of(context).size.width / 3
                  : MediaQuery.of(context).size.width / 10,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 0),
                child: Text(
                  widget.couponModel.mainTitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14.sp),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
