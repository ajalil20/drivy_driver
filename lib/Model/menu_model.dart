import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuModel {
  MenuModel({this.name,this.image,this.value,this.description,this.color,this.onTap});
  String? name, description, image;
  RxString? value;
  Color? color;
  Function? onTap;
}