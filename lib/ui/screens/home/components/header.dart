import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:qasimati/controller/ApiController.dart';
import 'package:qasimati/ui/screens/Search/seaechScreen.dart';

class Header extends StatefulWidget implements PreferredSizeWidget {
  Header({Key key})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  _HeaderState createState() => _HeaderState();

  @override
  final Size preferredSize;
}

class _HeaderState extends State<Header> {
  var controller = Get.find<ApiController>();
  String dropdown;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApiController>(
      init: ApiController(),
      builder: (controller1) {
        return AppBar(
          shadowColor: Theme.of(context).primaryColor,
          centerTitle: true,
          leading: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: IconButton(
              onPressed: () {
                Get.to(SearchScreen());
              },
              icon: Icon(
                Icons.search_rounded,
                size: MediaQuery.of(context).size.width / 13,
              ),
            ),
          ),
          title: Image.asset(
            'assets/images/Logo.png',
            width: MediaQuery.of(context).size.width / 3.5,
            height: MediaQuery.of(context).size.height / 12,
            color: Colors.white,
          ),
          actions: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              child: DropdownButtonHideUnderline(
                child: GFDropdown(
                  elevation: 12,
                  dropdownColor: Colors.white,
                  dropdownButtonColor: Theme.of(context).primaryColor,
                  iconEnabledColor: Colors.white,
                  iconDisabledColor: Colors.white,
                  value: controller.dropdownValue,
                  icon: Visibility(
                    visible: controller.dropdownValue == null,
                    child: FaIcon(Icons.public,
                        size: MediaQuery.of(context).size.width / 13),
                  ),
                  onChanged: (newValue) {
                    setState(() {
                      dropdown = newValue;
                      controller1.dropdownValue = newValue;
                      controller1.saveCountry();
                      controller1.getSliders();
                      controller1.getStores();
                      controller1.getCategories();
                      controller1.getBestStores();
                      controller.getAllCouponInStore();
                      controller
                          .getCouponsByCategory(controller.selectCategoryName);
                    });
                  },
                  items: controller1.allcountries
                      .map((value) => DropdownMenuItem(
                            value: value.shortcut,
                            child: Container(
                              decoration: BoxDecoration(),
                              child: Image.network(
                                value.image,
                                width: MediaQuery.of(context).size.width / 9,
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
          ],
          backgroundColor: Theme.of(context).primaryColor,
        );
      },
    );
  }
}
