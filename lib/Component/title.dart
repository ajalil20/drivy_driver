import 'package:flutter/material.dart';
import 'package:drivy_driver/Component/custom_text.dart';
import 'package:drivy_driver/Utils/my_colors.dart';

class ScreenTitle extends StatelessWidget {
  String? title;
  FontWeight? fontWeight;
  double?size;
  ScreenTitle({Key? key,this.title,this.fontWeight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyText(
      title: title??'',
      clr: Color(0xff221F20),
      fontWeight: FontWeight.w600,
      size: size??24,
    );
      // MyText(title: title??"",fontWeight: fontWeight??FontWeight.w500,size: 17,clr: MyColors().whiteColor,);
  }
}
