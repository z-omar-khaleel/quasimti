import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qasimati/controller/ApiController.dart';
import 'package:qasimati/ui/widgets/ItemCoupon.dart';

class Copouns extends StatefulWidget {
  @override
  _CopounsState createState() => _CopounsState();
}

class _CopounsState extends State<Copouns> {
  @override
  void initState() {
    // controller.getCouponsByCategory(controller.selectCategoryName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApiController>(
      builder: (controller) {
        return controller.allCoupons.isEmpty
            ? Center(child: Container())
            : Container(
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.allCoupons.length,
                    itemBuilder: (context, index) {
                      return ItemCoupon(controller.allCoupons[index]);
                    }),
              );
      },
    );
  }
}
