import 'package:flutter/material.dart';
import 'package:drivy_driver/Utils/my_colors.dart';
import 'package:sizer/sizer.dart';

class BorderedContainer extends StatelessWidget {
   BorderedContainer({Key? key,this.child,this.borderColor}) : super(key: key);
   Widget? child;
   Color? borderColor;


  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            border: Border.all(color: borderColor??MyColors().pinkColor,width: 1.5)
        ),
        padding: EdgeInsets.all(.8.w),
        child: child
    );
  }
}
