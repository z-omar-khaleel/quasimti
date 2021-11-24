import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qasimati/data/ApiHelper.dart';
import 'package:qasimati/ui/screens/home/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddController extends GetxController {
  final GlobalKey<FormState> addKey = GlobalKey<FormState>();
  TextEditingController nameController,
      soreName,
      storeName,
      storeLink,
      descrption,
      type,
      code,
      linkStore,
      link;

  TextEditingController dateinputEnter = TextEditingController();
  TextEditingController dateinputEnd = TextEditingController();
  DateTime pickedDateEnter;
  DateTime pickedDateEnd;
  XFile image;
  File fileImage;
  List<String> selectedCountry = [];
  imgFromGallery() async {
    ImagePicker picker = ImagePicker();
    image = await picker.pickImage(
      source: ImageSource.gallery,
    );
    fileImage = File(image.path ?? "");
    update();
  }

  @override
  void onInit() {
    nameController = TextEditingController();
    soreName = TextEditingController();
    storeName = TextEditingController();
    storeLink = TextEditingController();
    descrption = TextEditingController();
    type = TextEditingController();
    code = TextEditingController();
    linkStore = TextEditingController();
    link = TextEditingController();

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  String validateName(String value) {
    if (!GetUtils.isUsername(value)) {
      return "Username is not vaild";
    }
    return null;
  }

  String validatLabel(String value) {
    if (value.trim().isEmpty) {
      return "Required".tr;
    }
    return null;
  }

  String validatePassword(String value) {
    if (value.length <= 6) {
      return "password must be of 6";
    }
    return null;
  }

  checkAdd() async {
    if (addKey.currentState.validate() && fileImage != null) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      int id = preferences.get('id');
      addKey.currentState.save();
      var selectedCountryJson = jsonEncode(selectedCountry);
      Future<dynamic> response = ApiHelper.apiHelper.addCoupon(
        nameStore: storeName.text,
        linkstore: storeLink.text,
        urlStore: fileImage,
        countries: selectedCountryJson,
        code: code.text,
        descrption: descrption.text,
        startDate: dateinputEnter.text,
        endDate: dateinputEnd.text,
        id: id,
        type: type.text,
      );

      response.then((value) {
        if (value['status'] == 200) {
          Get.snackbar(
            "Done".tr,
            "Your request has been submitted successfully".tr,
          );
          Timer(Duration(seconds: 2), () {
            Get.offAll(HomeScreen());
          });
          soreName.clear();
          storeName.clear();
          storeLink.clear();
          descrption.clear();
          type.clear();
          code.clear();
          linkStore.clear();
          dateinputEnter.clear();
          dateinputEnd.clear();
          link.clear();
          fileImage = null;
        }
      });
    } else {
      Get.snackbar(
        "Sorry".tr,
        "Check all entries".tr,
      );
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
