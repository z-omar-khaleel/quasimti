import 'package:dashed_container/dashed_container.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:flutter_datetime_picker/flutter_datetime_picker.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:get/get.dart';
import 'package:qasimati/controller/AddController.dart';
import 'package:qasimati/controller/ApiController.dart';
import 'package:qasimati/models/country.dart';
import 'package:qasimati/ui/widgets/CustomButton.dart';

class AddCoubon extends StatefulWidget {
  @override
  _AddCoubonState createState() => _AddCoubonState();
}

class _AddCoubonState extends State<AddCoubon> {
  final controller = Get.find<AddController>();
  List<Country> country = [];

  String dropdownValue = "coupon";
  TextEditingController dateinputEnter = TextEditingController();
  TextEditingController dateinputEnd = TextEditingController();
  DateTime pickedDateEnter;
  DateTime pickedDateEnd;
  String local = Get.locale.toString();
  ApiController controller1 = Get.find<ApiController>();

  GlobalKey<FormFieldState<dynamic>> key = GlobalKey();
  @override
  void initState() {
    country = controller1.allcountries;
    controller.type.text = dropdownValue;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: GetBuilder<AddController>(
          init: AddController(),
          builder: (controller) {
            return Form(
              key: controller.addKey,
              child: ListView(
                children: [
                  ListTile(
                    title: Center(
                        child: Text(
                      "Add a discount code".tr,
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.bold),
                    )),
                    leading: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Theme.of(context).primaryColor,
                          size: 24,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ], // changes position of shadow
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Store details".tr,
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold)),
                          ),
                          TextFormField(
                            controller: controller.storeName,
                            onSaved: (s) {
                              controller.storeName.text = s;
                            },
                            validator: (v) {
                              return controller.validatLabel(v);
                            },
                            decoration:
                                InputDecoration(labelText: "Store name".tr),
                          ),
                          TextFormField(
                            controller: controller.storeLink,
                            onSaved: (s) {
                              controller.storeLink.text = s;
                            },
                            validator: (v) {
                              return controller.validatLabel(v);
                            },
                            decoration:
                                InputDecoration(labelText: " Store Link".tr),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          GestureDetector(
                            onTap: () async {
                              controller.imgFromGallery();
                            },
                            child: DashedContainer(
                              dashColor: Theme.of(context).primaryColor,
                              borderRadius: 10.0,
                              dashedLength: 3.0,
                              blankLength: 5.0,
                              strokeWidth: 2.0.w,
                              child: Container(
                                height: MediaQuery.of(context).size.height / 14,
                                decoration: BoxDecoration(
                                  color: controller.fileImage != null
                                      ? Theme.of(context)
                                          .primaryColor
                                          .withOpacity(.5)
                                      : Colors.white,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.cloud_upload,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Text(
                                        controller.fileImage != null
                                            ? "Done".tr
                                            : "Upload Logo".tr,
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                                child: Text(
                              "Jpg".tr,
                              style: TextStyle(fontSize: 12.sp),
                            )),
                          ),
                          MultiSelectDialogFormField(
                            cancelText: Text("CANCEL".tr),
                            confirmText: Text("Ok".tr),
                            buttonText: Text("Countries".tr),
                            title: Text("Countries".tr),
                            key: key,
                            items: country
                                .map((e) =>
                                    MultiSelectItem(e.id.toString(), e.name))
                                .toList(),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Required".tr;
                              }
                              return null;
                            },
                            onConfirm: (values) {
                              setState(() {
                                controller.selectedCountry = values;
                                print(controller.selectedCountry);
                              });
                              key.currentState.validate();
                              key.currentState.save();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ], // changes position of shadow
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Discount Details".tr,
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Row(
                            children: [
                              Text("Type:".tr),
                              Expanded(
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height / 14,
                                  margin: EdgeInsets.all(10),
                                  child: DropdownButtonHideUnderline(
                                    child: GFDropdown(
                                      padding: const EdgeInsets.all(15),
                                      borderRadius: BorderRadius.circular(5),
                                      border: const BorderSide(
                                          color: Colors.black12, width: 1),
                                      dropdownButtonColor: Colors.white,
                                      value: dropdownValue,
                                      onChanged: (newValue) {
                                        setState(() {
                                          dropdownValue = newValue;
                                          controller.type.text = dropdownValue;
                                          print("${controller.type.text}");
                                        });
                                      },
                                      items: [
                                        DropdownMenuItem(
                                          child: Text("copuon".tr,
                                              style:
                                                  TextStyle(fontSize: 14.sp)),
                                          value: 'coupon',
                                        ),
                                        DropdownMenuItem(
                                          child: Text("offer".tr,
                                              style:
                                                  TextStyle(fontSize: 14.sp)),
                                          value: 'offer',
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          dropdownValue == "offer"
                              ? TextFormField(
                                  controller: controller.code,
                                  validator: (v) {
                                    return controller.validatLabel(v);
                                  },
                                  onSaved: (s) {
                                    controller.code.text = s;
                                  },
                                  decoration: InputDecoration(
                                      labelText: "Link offer".tr),
                                )
                              : TextFormField(
                                  controller: controller.link,
                                  validator: (v) {
                                    return controller.validatLabel(v);
                                  },
                                  onSaved: (s) {
                                    controller.code.text = s;
                                  },
                                  decoration: InputDecoration(
                                      labelText: "Copun code".tr),
                                ),
                          Container(
                              child: Center(
                                  child: TextFormField(
                            controller: controller.dateinputEnter,
                            onSaved: (s) {
                              controller.dateinputEnter.text = s;
                            },
                            validator: (v) {
                              return controller.validatLabel(v);
                            },
                            decoration: InputDecoration(
                                icon: Icon(Icons.calendar_today),
                                labelText: "Start Date".tr),
                            readOnly: true,
                            onTap: () async {
                              DateTime pickedDate =
                                  await DatePicker.showDatePicker(context,
                                      showTitleActions: true,
                                      minTime: DateTime(2000),
                                      maxTime: DateTime(2100),
                                      onChanged: (date) {
                                print('change $date');
                              }, onConfirm: (date) {
                                print('confirm $date');
                              },
                                      currentTime: DateTime.now(),
                                      locale: 'ar' == local
                                          ? LocaleType.ar
                                          : LocaleType.en);

                              if (pickedDate != null) {
                                print(pickedDate);
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);

                                setState(() {
                                  dateinputEnter.text = formattedDate;
                                  controller.dateinputEnter = dateinputEnter;
                                  print(controller.dateinputEnter.text);
                                });
                              } else {
                                print("Date is not selected".tr.tr);
                              }
                            },
                          ))),
                          Container(
                              child: Center(
                                  child: TextFormField(
                            validator: (v) {
                              return controller.validatLabel(v);
                            },
                            onSaved: (s) {
                              controller.dateinputEnd.text = s;
                            },
                            controller: controller.dateinputEnd,
                            decoration: InputDecoration(
                                icon: Icon(Icons.calendar_today),
                                labelText: "End Date".tr),
                            readOnly: true,
                            onTap: () async {
                              DateTime pickedDate =
                                  await DatePicker.showDatePicker(context,
                                      showTitleActions: true,
                                      minTime: DateTime(2000),
                                      maxTime: DateTime(2100),
                                      onChanged: (date) {
                                print('change $date');
                              }, onConfirm: (date) {
                                print('confirm $date');
                              },
                                      currentTime: DateTime.now(),
                                      locale: 'ar' == local
                                          ? LocaleType.ar
                                          : LocaleType.en);
                              if (pickedDate != null) {
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                print(formattedDate);

                                setState(() {
                                  dateinputEnd.text = formattedDate;
                                  controller.dateinputEnd = dateinputEnd;
                                });
                              } else {
                                print("Date is not selected".tr);
                              }
                            },
                          ))),
                          TextFormField(
                            controller: controller.descrption,
                            onSaved: (s) {
                              controller.descrption.text = s;
                            },
                            decoration: InputDecoration(
                                labelText: " Descreotion(optional)".tr),
                          ),
                          SizedBox(height: 30.h),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ], // changes position of shadow
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Addition Terms'.tr,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15.sp),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            'e-shop'.tr,
                            style: TextStyle(
                              fontSize: 14.sp,
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            'Valid'.tr,
                            style: TextStyle(
                              fontSize: 14.sp,
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            'frequent'.tr,
                            style: TextStyle(
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 46.h,
                      child: CustomButton("Add".tr, () {
                        controller.checkAdd();
                      }, Theme.of(context).primaryColor, Colors.white),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
