import 'dart:ui';
import 'package:drivy_driver/Utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:drivy_driver/Component/custom_blur.dart';
import 'package:drivy_driver/Utils/image_path.dart';
import 'package:sizer/sizer.dart';

class CustomBackgroundImage extends StatelessWidget {
  final Widget? child;
  final Alignment? align;
  final String? image;
  final bool? blurEffect;

  const CustomBackgroundImage({super.key,
    this.child,
    this.image,
    this.align,
    this.blurEffect=false,
  });

  @override
  // Widget build(BuildContext context) {
  //   return Container(
  //       width: 100.sw,
  //       decoration: const BoxDecoration(
  //         // color: Colors.transparent,
  //         image: DecorationImage(
  //           // fit: BoxFit.fill,
  //             image: AssetImage(
  //               ImagePath.backgroundImage,
  //             ),
  //             fit: BoxFit.cover
  //         ),
  //       ),
  //       alignment:align??Alignment.center,
  //       child: child
  //   );
  // }

  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      width: 100.h,
      decoration: BoxDecoration(
        image: image==null?null: DecorationImage(
            image: AssetImage(image!),
            fit: BoxFit.cover),
        color: MyColors().whiteColor,
      ),
      child: Scaffold(
          body: Container(
          height: 100.h,
          width: 100.h,
          decoration: BoxDecoration(
          color: image!=null?null: MyColors().whiteColor,
          ),
          child: SafeArea(child: child!))),
    ) ;
  }

}
