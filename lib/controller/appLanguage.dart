import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qasimati/utils/localStorage/localStorge.dart';

class AppLanguage extends GetxController {
  var appLocal = "ar";
  var seletedCointry = 'all';
  int inial;
  @override
  void onInit() async {
    super.onInit();

    LocalStorage localStorage = LocalStorage();
    appLocal = await localStorage.languageSelected == null
        ? 'ar'
        : await localStorage.languageSelected;
    Get.updateLocale(Locale(appLocal));
    inial = await localStorage.toggleSelected;

    update();
  }

  void changeLanguage(String type) async {
    LocalStorage localStorage = LocalStorage();
    if (appLocal == type) {
      return;
    }
    if (type == 'ar') {
      appLocal = "ar";
      localStorage.saveLanguage('ar');
      localStorage.saveToggle(inial);
      inial = await localStorage.toggleSelected;
    } else {
      appLocal = "en";
      localStorage.saveLanguage('en');
      localStorage.saveToggle(inial);
      inial = await localStorage.toggleSelected;
    }
  }
}
