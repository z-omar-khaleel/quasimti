import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:qasimati/data/ApiHelper.dart';
import 'package:qasimati/ui/screens/home/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  GlobalKey<FormState> loginKey;
  GlobalKey<FormState> singupFromKey;
  GlobalKey<FormState> updateForm;
  GlobalKey<FormState> contactForm;
  GlobalKey<FormState> forgetKey;
  TextEditingController emailController,
      passwordCotroller,
      nameController,
      nameEdit,
      passwordEdit,
      emialEdit,
      subjectController,
      bodyController;

  String name;
  String token;
  String imageUrl = "";
  File imageFile;
  File imageEdit;
  String verify = "A";

  @override
  void onInit() {
    emailController = TextEditingController();
    passwordCotroller = TextEditingController();
    nameController = TextEditingController();
    nameEdit = TextEditingController();
    passwordEdit = TextEditingController();
    emialEdit = TextEditingController();
    loginKey = GlobalKey<FormState>();
    singupFromKey = GlobalKey<FormState>();
    updateForm = GlobalKey<FormState>();
    subjectController = TextEditingController();
    contactForm = GlobalKey<FormState>();
    bodyController = TextEditingController();
    forgetKey = GlobalKey<FormState>();
    getUser();
    getToken();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  String validateName(String value) {
    if (value.trim().isEmpty) {
      return "Username is not Empty".tr;
    }
    return null;
  }

  String validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return "Eamil is not vaild".tr;
    }
    return null;
  }

  String validatePassword(String value) {
    if (value.length <= 6) {
      return "Password must be greater than 6".tr;
    }
    return null;
  }

  checkLogin() async {
    try {
      if (loginKey.currentState.validate()) {
        loginKey.currentState.save();
        dynamic response = await ApiHelper.apiHelper
            .login(passwordCotroller.text, emailController.text);

        if (response.data['status'] == 404) {
          Get.snackbar("Wrong".tr, "Not Found".tr);
        } else if (response.data['status'] == 401) {
          Get.snackbar("Wrong".tr, "wrong password".tr);
        } else if (response.data['data']['status'] == 200) {
          saveToken(
              response.data['data']['access_token'],
              response.data['data']['name'],
              response.data['data']['id'],
              response.data['data']['verified_at'] ?? "A");
          Get.offAll(HomeScreen());
          Get.snackbar("Done".tr, "You are logged in successfully".tr);
          emailController.text = '';
          passwordCotroller.text = '';
        }
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  saveToken(String token, String name, int id, String verify) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("token", token);
    await pref.setString("name", name);
    await pref.setInt('id', id);
    await pref.setString("verify", verify ?? "A");
    update();
  }

  saveName(String name) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("name", name);
  }

  getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    token = pref.get('token');
    name = pref.get('name');
    verify = pref.get('verify');
    update();
  }

  removeToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove('token');
    await pref.remove('name');
    await pref.remove("id");
    name = null;
    token = null;
    update();
  }

  checkSignUp() async {
    try {
      if (singupFromKey.currentState.validate()) {
        singupFromKey.currentState.save();
        dynamic response = await ApiHelper.apiHelper.register(
            name: nameController.text,
            url: imageFile,
            password: passwordCotroller.text,
            email: emailController.text);
        if (response.statusCode == 201) {
          saveToken(response.data['data']['access_token'],
              response.data['data']['name'], response.data['data']['id'], "A");
          token = response.data['data']['access_token'];
          verifiyEmail();

          Get.offAll(HomeScreen());
          Get.snackbar("Done".tr, "successfully registered".tr);
          emailController.clear();
          passwordCotroller.clear();
          imageFile = null;
          nameController.clear();
        } else {
          Get.snackbar("Wrong".tr, "This email has already been registered".tr);
        }
      } else {
        print('');
      }
    } on Exception catch (e) {
      print(e);
    }
    update();
  }

  getUser() async {
    dynamic response = await ApiHelper.apiHelper.getUserByToken(token);
    if (response != null) {
      if (response.statusCode == 200) {
        nameEdit.text = response.data['data']['name'];
        emialEdit.text = response.data['data']['email'];
        imageUrl = response.data['data']['image'];
        verify = response.data['data']['email_verified_at'] ?? "A";

        saveToken(
            token,
            response.data['data']['name'],
            response.data['data']['id'],
            response.data['data']['email_verified_at'] ?? "A");

        update();
      }
    }
  }

  upDate() async {
    try {
      dynamic response = await ApiHelper.apiHelper
          .update(nameEdit.text, imageEdit, passwordEdit.text, token);
      print(passwordEdit.text);
      print(response);
      if (response.statusCode == 200) {
        Get.snackbar(
            "Done".tr, "Your account has been successfully modified".tr);
        saveName(response.data['data']['name']);
        update();
        Get.offAll(HomeScreen());
        nameController.clear();
        passwordEdit.clear();
      } else {
        Get.snackbar("Wrong".tr, "Check input fields".tr);
      }
    } on Exception catch (e) {
      print(e);
    }
    update();
  }

  verifiyEmail() async {
    getToken();
    dynamic response = await ApiHelper.apiHelper.verifiyEmail(token);
    print(response);
    // if (response.statusCode == 422) {
    //   getUser();
    // }
  }

  forgetPassword() async {
    if (forgetKey.currentState.validate()) {
      forgetKey.currentState.save();
      dynamic response = await ApiHelper.apiHelper
          .forgetPassword(Get.locale.toString(), emailController.text);

      if (response.data['status'] == 200) {
        Get.snackbar('Done'.tr, response.data['message']);
        emailController.clear();
      } else if (response.data['status'] == 422) {
        Get.snackbar('Error'.tr, response.data['message']);
      }
    }
  }

  contactUs() async {
    if (contactForm.currentState.validate()) {
      contactForm.currentState.save();

      dynamic response = await ApiHelper.apiHelper.contactUs(
          nameController.text,
          emailController.text,
          bodyController.text,
          subjectController.text);

      if (response.statusCode == 200) {
        Get.snackbar('Done'.tr, 'Message sent successfully.'.tr);
        emailController.clear();
        bodyController.clear();
        subjectController.clear();
        nameController.clear();
        Get.offAll(HomeScreen());
      } else {
        Get.snackbar('Error'.tr, 'Check input fields'.tr);
      }
    } else {
      Get.snackbar('Error'.tr, 'Check input fields'.tr);
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordCotroller.dispose();

    super.onClose();
  }
}
