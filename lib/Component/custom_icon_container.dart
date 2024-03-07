import 'package:flutter/material.dart';
import 'package:drivy_driver/Utils/my_colors.dart';
import 'package:sizer/sizer.dart';

class IconContainer extends StatelessWidget {
  IconContainer({super.key,this.child,this.image,required this.onTap,this.size,this.padding});
  Widget? child;
  Function onTap;
  String? image;
  double? size, padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){onTap();},
      child: Image.asset(image!,scale: 2,)
    );
  }
}
