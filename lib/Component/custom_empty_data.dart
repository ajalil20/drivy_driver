import 'package:drivy_driver/Utils/image_path.dart';
import 'package:drivy_driver/Utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'custom_text.dart';
import 'package:sizer/sizer.dart';

class CustomEmptyData extends StatelessWidget {
  CustomEmptyData({Key? key,this.title, this.image,this.imageColor,this.hasLoader,this.paddingVertical}) : super(key: key);
  String? title, image;
  Color? imageColor;
  bool? hasLoader;
  double? paddingVertical;

  @override
  Widget build(BuildContext context) {
    return hasLoader==false? Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: paddingVertical??6.h),
        child: MyText(
          title: title??"Not available",
          clr: MyColors().black,
          size: 15,
        ),
      ),
    ):Stack(
      children: [
        SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Container(height: 100.h,),
        ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if(image!=null)...[
                Image.asset(image!,width: 6.w,color: imageColor,),
                SizedBox(width: 3.w,),
              ],
              MyText(
                title: title??"Not available",
                clr: MyColors().black,
                size: 15,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
