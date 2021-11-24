import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qasimati/controller/bindings.dart';
import 'package:qasimati/utils/splashScreen.dart';
import 'package:qasimati/translation.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await GetStorage.init();
  runApp(MyApp()); // starting point of app
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(392.72727272727275, 803.6363636363636),
        builder: () {
          return GetMaterialApp(
            initialBinding: Binding(),
            initialRoute: '/',
            color: Colors.white,
            translations: Translation(),
            locale: Locale('en'),
            fallbackLocale: Locale('en'),
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: Color(0xFF5F57A0),
              fontFamily: 'Jannat',
            ),
            home: SplashScreens(),
          );
        });
  }
}
