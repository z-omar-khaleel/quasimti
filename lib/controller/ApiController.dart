import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qasimati/data/ApiHelper.dart';
import 'package:qasimati/models/StoreModel.dart';
import 'package:qasimati/models/category.dart';
import 'package:qasimati/models/country.dart';
import 'package:qasimati/models/coupon.dart';
import 'package:qasimati/models/slider.dart';
import 'package:qasimati/ui/screens/Authication/LoginScreen.dart';
import 'package:qasimati/ui/screens/Authication/signUpScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiController extends GetxController {
  List<StoreModel> allStores = [];
  List<StoreModel> allBestStores = [];
  List<Country> allcountries = [];
  List<SliderModel> allsliders = [];
  List<CategoryModel> allCategories = [];
  List<CouponModel> allCoupons = [];
  List<CouponModel> allCouponStore = [];
  List<CouponModel> allstoreSearch = [];
  List<CouponModel> allfavorite = [];

  String selectCategoryName;
  String selectedStore;
  int selectCategory = -1;
  String dropdownValue;
  bool iscopy = false;
  toggle() {
    iscopy = true;
    Future.delayed(Duration(seconds: 3), () {
      iscopy = false;
      update();
    });
    update();
  }

  @override
  void onInit() {
    if(dropdownValue!=null){

    }
    getCountry();
    // print(allBestStores);
    super.onInit();
  }

  saveCountry() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("Country", dropdownValue);
    update();
  }

  getCountry() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    dropdownValue = pref.get("Country");
    getSliders();
    getStores();
    getCategories();
    getAllCountries();
    getBestStores();
    // getAllCouponInStore();
    getCouponsByCategory(selectCategoryName);
    update();
  }

  getAllCountries() async {
    try {
      List<dynamic> countries =
          await ApiHelper.apiHelper.getAllCountry(Get.locale.toString());
      if (countries != null) {
        allcountries = countries.map((e) => Country.fromJson(e)).toList();
      }
      update();
    } on Exception catch (e) {
      print(e);
    }
  }

  getSliders() async {
    try {
      if (dropdownValue == null) {
        List<dynamic> sliders = await ApiHelper.apiHelper.getSliders('all');
        if (sliders != null) {
          allsliders = sliders.map((e) => SliderModel.fromJson(e)).toList();
        } else {
          // Get.snackbar("Error", "No EnterNet");
        }
      } else {
        List<dynamic> sliders =
            await ApiHelper.apiHelper.getSliders(dropdownValue);
        if (sliders != null) {
          allsliders = sliders.map((e) => SliderModel.fromJson(e)).toList();
        }
      }
    } on Exception catch (e) {
      // Get.snackbar("Error".tr, "No internet connection".tr);
      print(e);
    }
    update();
  }

  getStores() async {
    try {
      if (dropdownValue == null) {
        List<dynamic> stores =
            await ApiHelper.apiHelper.getStores('all', Get.locale.toString());
        if (stores != null) {
          allStores = stores.map((e) => StoreModel.fromJson(e)).toList();
          update();
        }
      } else {
        List<dynamic> stores = await ApiHelper.apiHelper
            .getStores(dropdownValue, Get.locale.toString());
        if (stores != null) {
          allStores = stores.map((e) => StoreModel.fromJson(e)).toList();
          update();
        }
      }
    } on Exception catch (e) {
      // Get.snackbar("Error".tr, "No internet connection".tr);
      print(e);
    }
  }

  getBestStores() async {
    try {
      if (dropdownValue == null) {
        List<dynamic> stores = await ApiHelper.apiHelper
            .getBestStores('all', Get.locale.toString());
        if (stores != null) {
          allBestStores = stores.map((e) => StoreModel.fromJson(e)).toList();
          update();
        }
      } else {
        List<dynamic> stores = await ApiHelper.apiHelper
            .getBestStores(dropdownValue, Get.locale.toString());
        if (stores != null) {
          allBestStores = stores.map((e) => StoreModel.fromJson(e)).toList();
          update();
        }
      }
    } on Exception catch (e) {
      // Get.snackbar("Error".tr, "No internet connection".tr);
      print(e);
    }
  }

  getCategories() async {
    try {
      List<dynamic> categories =
          await ApiHelper.apiHelper.getCategory(Get.locale.toString());
      if (categories != null) {
        allCategories =
            categories.map((e) => CategoryModel.fromJson(e)).toList();

        update();
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  getCouponsByCategory(String category) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int id = sharedPreferences.getInt('id');

    try {
      if (selectCategory == -1) {
        selectCategoryName = 'all';
      }
      if (dropdownValue == null) {
        print("a");
        List<dynamic> coupons = await ApiHelper.apiHelper
            .getAllCoupon('all', Get.locale.toString(), id);
        allCoupons = coupons.map((e) => CouponModel.fromJson(e)).toList();
        update();
      } else {
        if (selectCategoryName == "all") {
          List<dynamic> coupons = await ApiHelper.apiHelper
              .getAllCoupon(dropdownValue, Get.locale.toString(), id);
          allCoupons = coupons.map((e) => CouponModel.fromJson(e)).toList();
          update();
        }
        List<dynamic> coupons = await ApiHelper.apiHelper.getCouponsByCategory(
            selectCategoryName, dropdownValue, Get.locale.toString(), id);
        if (coupons != null) {
          allCoupons = coupons.map((e) => CouponModel.fromJson(e)).toList();
          update();
        }
      }
    } on Exception catch (e) {
      // Get.snackbar("Error".tr, "No internet connection".tr);
      print(e);
    }
    update();
  }

  getAllCouponInStore() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int id = sharedPreferences.getInt('id');
    allCouponStore = [];
    try {
      if (dropdownValue == null) {
        print('notselected');
        update();
      } else {
        if (dropdownValue == null) {
          List<dynamic> couponsStore = await ApiHelper.apiHelper
              .getAllCouponInStore(
                  selectedStore, "SA", Get.locale.toString(), id);
          if (couponsStore.isNotEmpty) {
            allCouponStore =
                couponsStore.map((e) => CouponModel.fromJson(e)).toList();

            update();
          } else {
            // Get.snackbar("Error".tr, "No internet connection".tr);
          }
        } else {
          List<dynamic> couponsStore = await ApiHelper.apiHelper
              .getAllCouponInStore(
                  selectedStore, dropdownValue, Get.locale.toString(), id);
          if (couponsStore != null) {
            allCouponStore =
                couponsStore.map((e) => CouponModel.fromJson(e)).toList();

            update();
          } else {
            // Get.snackbar("Error".tr, "No internet connection".tr);
          }
        }
      }
    } on Exception catch (e) {
      Get.snackbar("Error".tr, "No internet connection".tr);
      print(e);
    }
  }

  voteCoupon(String type, int id) async {
    try {
      dynamic response = await ApiHelper.apiHelper
          .vaildCoupon(type, id, Get.locale.toString());
      print(response);

      getCouponsByCategory(selectCategoryName);
      getAllCouponInStore();
      update();

      return response;
    } on Exception catch (e) {
      // Get.snackbar("Error".tr, "No internet connection".tr);
      print(e);
    }
  }

  searchStore(String query) async {
    allstoreSearch = [];
    try {
        List<dynamic> storeSearch = await ApiHelper.apiHelper
            .search(dropdownValue, Get.locale.toString(), query);
        if (storeSearch != null) {
          allstoreSearch =
              storeSearch.map((e) => CouponModel.fromJson(e)).toList();
          update();
        } else {
          // print(storeSearch);


        }

    } on Exception catch (e) {
      // Get.snackbar("Error".tr, "No internet connection".tr);
      print(e);
    }
  }

  addFavavrite(int couponId, BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('token');
    dynamic response = await ApiHelper.apiHelper.addFavorite(token, couponId);
    if (response.statusCode == 401) {
      Get.defaultDialog(
        title: "Sorry".tr,
        titleStyle: TextStyle(color: Colors.black87),
        content: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "You can add coupons to your favourite when you log in".tr,
                style: TextStyle(fontSize: 18, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 19,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(15)),
                  child: TextButton(
                      onPressed: () {
                        Get.off(Login());
                      },
                      child: Text(
                        "Sign In".tr,
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(15)),
                  child: TextButton(
                      onPressed: () {
                        Get.off(SignUp());
                      },
                      child: Text(
                        "Sign Up".tr,
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ],
            ),
          ],
        ),
      );
    } else {
      return true;
    }
    getCouponsByCategory(selectCategoryName);
    getAllCouponInStore();
    getFavoriteCoupon();

    update();
    return true;
  }

  deleteFavavrite(int couponId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('token');
    // ignore: unused_local_variable
    dynamic response =
        await ApiHelper.apiHelper.deleteFavorite(token, couponId);
    getCouponsByCategory(selectCategoryName);
    getAllCouponInStore();
    getFavoriteCoupon();
    update();
  }

  getFavoriteCoupon() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token');

    try {
      List<dynamic> favorite = await ApiHelper.apiHelper
          .getFavoriteCoupons(Get.locale.toString(), token);
      if (favorite != null) {
        allfavorite = favorite.map((e) => CouponModel.fromJson(e)).toList();
        // print(favorite);
        update();
      } else {
        // Get.snackbar("Error".tr, "No internet connection".tr);
      }
    } on Exception catch (e) {
      Get.snackbar("Error".tr, "No internet connection".tr);
      print(e);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
