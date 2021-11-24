import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/shimmer/gf_shimmer.dart';
import 'package:qasimati/controller/ApiController.dart';
import 'package:qasimati/ui/widgets/ItemCoupon.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  ApiController controller;
  TextEditingController textController = TextEditingController();
  String dropdownValue = 'One';
  @override
  void initState() {
    super.initState();
    controller = Get.find<ApiController>();
    controller.searchStore("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18 ),
              color: Theme.of(context).primaryColor,
              height: MediaQuery.of(context).size.height / 12,
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/images/Logo.png',
                      width: MediaQuery.of(context).size.width / 4.8,
                      height: MediaQuery.of(context).size.height / 10,
                      color: Colors.white,
                    ),
                  ),
                  GetBuilder<ApiController>(
                      init: ApiController(),
                      builder: (controller) {
                        return Container(
                          child: Expanded(
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              child: TextFormField(
                                onChanged: (v) {
                                  controller.searchStore(v);
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(5),
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: 'Search'.tr,
                                  hintStyle: TextStyle(fontSize: 18.sp),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(30)),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            // SizedBox(
            //   height: 20.h,
            // ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 10.h,bottom: 10.h),
                child: GetBuilder<ApiController>(
                  builder: (controller) {
                    return controller.allstoreSearch.isEmpty
                        ? Center(
                            child: GFShimmer(
                            child: Text("No result".tr,style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold),),
                          ))
                        : Container(
                            height: MediaQuery.of(context).size.height,
                            child: ListView.builder(
                                itemCount: controller.allstoreSearch.length,
                                itemBuilder: (context, index) {
                                  return ItemCoupon(
                                      controller.allstoreSearch[index]);
                                }),
                          );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
