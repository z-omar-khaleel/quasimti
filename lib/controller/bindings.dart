import 'package:get/get.dart';
import 'package:qasimati/controller/AddController.dart';
import 'package:qasimati/controller/ApiController.dart';
import 'package:qasimati/controller/AuthController.dart';
import 'package:qasimati/controller/appLanguage.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.put(ApiController());
    Get.put(AppLanguage());
    Get.put(AuthController());
    Get.put(AddController());
  }
}
