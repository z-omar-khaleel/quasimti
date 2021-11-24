import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qasimati/controller/ApiController.dart';
import 'package:qasimati/ui/screens/home/components/categories.dart';
import 'package:qasimati/ui/screens/home/components/copouns.dart';
import 'package:qasimati/ui/screens/home/components/slider.dart';
import 'package:qasimati/ui/screens/home/components/stores.dart';

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  ApiController controller;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          Container(margin: EdgeInsets.only(top: 15.h), child: Sliders()),
          Container(
              margin: EdgeInsets.only(
                  top: 12.h,
                  left: Get.locale.toString() == "en" ? 20.w : 0,
                  right: Get.locale.toString() == "ar" ? 20.w : 0),
              child: StoresComponet()),
          Container(
            margin: EdgeInsets.only(
                top: 12.h,
                left: Get.locale.toString() == "en" ? 20.w : 0,
                right: Get.locale.toString() == "ar" ? 20.w : 0),
            child: Categorylist(),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 16.h),
              child: Copouns()),
        ],
      ),
    );
  }
}
