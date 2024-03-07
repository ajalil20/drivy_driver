import 'package:flutter/material.dart';
import 'package:drivy_user/Utils/my_colors.dart';
import 'package:sizer/sizer.dart';
import '../../Component/custom_text.dart';

class ViewAll extends StatelessWidget {
  ViewAll({Key? key,this.title,this.onTap,this.trailing}) : super(key: key);
  String? title;
  Function? onTap;
  Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return  Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: MyText(title: title??"",size: 17,clr: MyColors().blueColor,fontWeight: FontWeight.w700,)),
        SizedBox(width: 4.w,),
        InkWell(
          onTap: () {
            onTap!();
          },
          child: trailing??MyText(title: "View All",size: 14 ,under: true,clr: MyColors().blueColor,fontWeight: FontWeight.w700)
        ),
      ],
    );
  }
}
