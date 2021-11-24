import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qasimati/controller/ApiController.dart';
import 'package:qasimati/ui/screens/home/home_screen.dart';
import 'package:qasimati/utils/ChosseCountry.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashScreens extends StatefulWidget {
  @override
  State<SplashScreens> createState() => _SplashScreensState();
}

class _SplashScreensState extends State<SplashScreens> {
  final  controller= Get.put(ApiController());
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApiController>(

      builder: (controller) {
        return new SplashScreen(
            seconds: 3,
            navigateAfterSeconds: controller.dropdownValue==null? ChoseCountry():HomeScreen(),
            image: new Image.asset(
              'assets/images/Logo.png',
              color: Colors.white,
            ),
            backgroundColor: Theme.of(context).primaryColor,
            styleTextUnderTheLoader: new TextStyle(),
            photoSize: 100.0,
            loaderColor: Colors.white);
      }
    );
  }
}
