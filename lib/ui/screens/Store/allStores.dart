import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/getwidget.dart';
import 'package:qasimati/controller/ApiController.dart';
import 'package:qasimati/ui/screens/Store/store_screen.dart';

class AllStores extends StatefulWidget {
  @override
  _AllStoresState createState() => _AllStoresState();
}

class _AllStoresState extends State<AllStores> {
  ApiController controller;
  @override
  void initState() {
    controller = Get.find<ApiController>();
    controller.getStores();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "Stores".tr,
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: GetBuilder<ApiController>(
        init: ApiController(),
        builder: (c) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: c.allStores.isEmpty
                ? GFLoader(
                    type: GFLoaderType.ios,
                  )
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemBuilder: (context, position) {
                      return GestureDetector(
                        onTap: () async {
                          c.selectedStore = c.allStores[position].name;
                          c.getAllCouponInStore();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StoreScreen()));
                        },
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Color(0xFFD1D8E5))),
                              child: GFAvatar(
                                foregroundColor: Colors.transparent,
                                backgroundColor: Colors.white,
                                size: MediaQuery.of(context).size.width / 4,
                                child: Image(
                                  image:
                                      NetworkImage(c.allStores[position].image),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  child: Text(
                                    c.allStores[position].name,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    itemCount: c.allStores.length,
                  ),
          );
        },
      ),
    );
  }
}
