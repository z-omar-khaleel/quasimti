import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qasimati/controller/AuthController.dart';

class EditScreen extends StatefulWidget {
  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  AuthController controller;
  File _image;
  imgFromGallery() async {
    ImagePicker picker = ImagePicker();
    XFile image = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = File(image.path);

      controller.imageEdit = _image;
    });
  }

  @override
  void initState() {
    controller = Get.find<AuthController>();
    controller.getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Edit Account".tr,
          style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black),
        ),
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
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 15),
        child: ListView(
          children: [
            GetBuilder<AuthController>(
              builder: (controller) {
                return Form(
                  key: controller.updateForm,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ], // changes position of shadow
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          controller.imageUrl != ""
                              ? GestureDetector(
                                  onTap: () {
                                    imgFromGallery();
                                    controller.imageUrl = "";
                                  },
                                  child: Center(
                                    child: Container(
                                      width:
                                          MediaQuery.of(context).size.width / 4,
                                      height:
                                          MediaQuery.of(context).size.width / 4,
                                      child: CircleAvatar(
                                        backgroundImage:
                                            NetworkImage(controller.imageUrl),
                                      ),
                                    ),
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    imgFromGallery();
                                  },
                                  child: Center(
                                    child: GFAvatar(
                                      radius: 50,
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                      child: _image != null
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              child: Center(
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      4,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      4,
                                                  child: CircleAvatar(
                                                      backgroundImage:
                                                          FileImage(_image)),
                                                ),
                                              ),
                                            )
                                          : Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.grey[200],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50)),
                                              width: 100,
                                              height: 100,
                                              child: Icon(
                                                Icons.camera_alt,
                                                color: Colors.grey[800],
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                          TextFormField(
                            controller: controller.nameEdit,
                            validator: (v) {
                              return controller.validateName(v);
                            },
                            onSaved: (s) {
                              controller.nameEdit.text = s;
                            },
                            decoration: InputDecoration(
                              labelText: "UserName".tr,
                              prefixIcon: Icon(Icons.person),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: controller.emialEdit,
                            enabled: false,
                            decoration: InputDecoration(
                              labelText: "Email".tr,
                              prefixIcon: Icon(Icons.email),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            obscureText: true,
                            controller: controller.passwordEdit,
                            // validator: (v) {
                            //   return controller.passwordEdit.validatePassword(v);
                            // },
                            onSaved: (s) {
                              controller.passwordEdit.text = s;
                            },
                            decoration: InputDecoration(
                              labelText: "password".tr,
                              prefixIcon: Icon(Icons.lock_outline),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 12,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50)),
                              child: GFButton(
                                shape: GFButtonShape.pills,
                                color: Theme.of(context).primaryColor,
                                child: Text(
                                  "Update".tr,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16.sp),
                                ),
                                onPressed: () {
                                  controller.upDate();
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
