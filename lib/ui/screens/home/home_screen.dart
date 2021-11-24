import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qasimati/ui/screens/Store/allStores.dart';
import 'package:qasimati/ui/screens/home/components/header.dart';
import 'package:qasimati/ui/screens/home/homeBody.dart';
import 'package:qasimati/ui/screens/proflie/profileScreen.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> children = [
    HomeBody(),
    AllStores(),
    ProfileScreen(),
  ];
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _currentIndex == 0 ? Header() : null,
      extendBody: true,
      body: children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: (index) => setState(() {
          _currentIndex = index;
        }),
        items: [
          BottomNavigationBarItem(
            icon:  SvgPicture.asset(
              "assets/images/Home-icon.svg",
              color:_currentIndex==0? Theme.of(context).primaryColor:Colors.black,
              width: 24.w,
              height: 24.h,
            ),
            label: 'Home'.tr,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/images/Iconly-Light-Ticket.svg",
              width: 24.w,
              height: 24.h,
              color: _currentIndex==1? Theme.of(context).primaryColor:Colors.black,
            ),
            label: 'Stores'.tr,
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/Profile.svg',
              width: 24.w,
              height: 24.h,
           color:   _currentIndex==2? Theme.of(context).primaryColor:Colors.black,
            ),
            label: 'Profile'.tr,
          ),
        ],
      ),
    );
  }
}
