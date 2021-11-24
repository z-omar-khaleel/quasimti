import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:qasimati/controller/ApiController.dart';
import 'package:qasimati/controller/appLanguage.dart';

import 'package:qasimati/ui/widgets/ItemCoupon.dart';

class StoreScreen extends StatefulWidget {
  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  ApiController controller;
  AppLanguage controller1;
  @override
  void initState() {
    controller = Get.find<ApiController>();
    controller.getAllCouponInStore();
    controller1 = Get.find<AppLanguage>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApiController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Image.asset(
            'assets/images/Logo.png',
            width: MediaQuery.of(context).size.width / 3.5,
            height: MediaQuery.of(context).size.height / 12,
            color: Colors.white,
          ),
          centerTitle: true,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: controller.allCouponStore.isEmpty
              ? GFLoader()
              : ListView.builder(
                  itemCount: controller.allCouponStore.length,
                  itemBuilder: (context, index) {
                    return ItemCoupon(controller.allCouponStore[index]);
                  }),
        ),
      );
    });
  }
}
