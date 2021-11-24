import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qasimati/controller/ApiController.dart';
import 'package:qasimati/ui/screens/Store/store_screen.dart';

class StoresComponet extends StatefulWidget {
  @override
  _StoresComponetState createState() => _StoresComponetState();
}

class _StoresComponetState extends State<StoresComponet> {
  var controller = Get.put(ApiController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApiController>(
      builder: (controller) {
        return controller.allBestStores.isEmpty
            ? Container()
            : Container(
                height: MediaQuery.of(context).size.height / 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 10.h),
                      child: Text(
                        "Best Stores".tr,
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.w700),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.allBestStores.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  controller.selectedStore =
                                      controller.allBestStores[index].name;

                                  controller.getAllCouponInStore();
                                  Get.to(StoreScreen());
                                },
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: Get.locale.toString() == "ar"
                                          ? 10.w
                                          : 0,
                                      right: Get.locale.toString() == "en"
                                          ? 10.w
                                          : 0),
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Color(0xFFD1D8E5)),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Image.network(
                                    controller.allBestStores[index].image,
                                    width: 100.w,
                                    height: 60.h,
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              );
      },
    );
  }
}
