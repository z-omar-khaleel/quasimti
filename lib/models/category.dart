// ignore: unused_import
import 'package:flutter/cupertino.dart';

class CategoryModel {
  int id;
  String image;
  String icon;
  String name;

  CategoryModel({
    this.id,
    this.image,
    this.icon,
    this.name,
  });

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    icon = json['icon'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['icon'] = this.icon;
    data['name'] = this.name;
    return data;
  }
}
