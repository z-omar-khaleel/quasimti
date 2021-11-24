import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/types/gf_loader_type.dart';
import 'package:qasimati/controller/ApiController.dart';

// We need stateful widget because we need to change some sate on our category
class Categorylist extends StatefulWidget {
  @override
  _CategorylistState createState() => _CategorylistState();
}

class _CategorylistState extends State<Categorylist> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApiController>(
      init: ApiController(),
      builder: (c) {
        return c.allCategories.isEmpty
            ? Center(
                child: GFLoader(
                type: GFLoaderType.ios,
              ))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10.h),
                    child: Text(
                      "Categories".tr,
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 23,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        GestureDetector(
                          onTap: () {
                            c.selectCategory = -1;
                            c.getCouponsByCategory(c.selectCategoryName);
                            c.update();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFFD1D8E5)),
                                borderRadius: BorderRadius.circular(20),
                                color: c.selectCategory == -1
                                    ? Theme.of(context)
                                        .primaryColor
                                        .withOpacity(.8)
                                    : Colors.white),
                            child: Text(
                              "All".tr,
                              style: TextStyle(
                                color: c.selectCategory == -1
                                    ? Colors.white
                                    : Colors.black.withOpacity(.5),
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.horizontal,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: c.allCategories.length,
                          itemBuilder: (context, index) => Row(
                            children: [
                              buildCategory(index, context),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
      },
    );
  }

  buildCategory(int index, BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(
              left: Get.locale.toString() == "ar" ? 5.w : 5.w,
              right: Get.locale.toString() == "en" ? 5.w : 5.w),
          child: GetBuilder<ApiController>(
            builder: (controller) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    controller.selectCategory = index;
                    controller.selectCategoryName =
                        controller.allCategories[index].name;
                    controller.getCouponsByCategory(
                        controller.allCategories[index].name);
                  });
                },
                child: controller.allCategories == null
                    ? CircularProgressIndicator()
                    : Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Color(0xFFD1D8E5)),
                            borderRadius: BorderRadius.circular(20),
                            color: index == controller.selectCategory
                                ? Theme.of(context).primaryColor.withOpacity(.8)
                                : Colors.white),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            controller.allCategories[index].image != null
                                ? Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: SvgPicture.network(
                                      controller.allCategories[index].image,
                                      color: index == controller.selectCategory
                                          ? Colors.white
                                          : Colors.black,
                                      width: 24.w,
                                      height: 24.h,
                                    ),
                                  )
                                : Container(),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              controller.allCategories[index].name ?? "",
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  color: index == controller.selectCategory
                                      ? Colors.white
                                      : Colors.black.withOpacity(.5),
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
              );
            },
          ),
        ),
      ],
    );
  }
}
