import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:drivy_driver/Utils/image_path.dart';

class AppLogo extends StatefulWidget {
  AppLogo({Key? key,this.onTap}) : super(key: key);
  Function? onTap;

  @override
  State<AppLogo> createState() => _AppLogoState();
}

class _AppLogoState extends State<AppLogo> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          if( widget.onTap!=null) {
            widget.onTap!();
          }
        },
        child: Container(
          height: 12.h,
          width: 60.w,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            image: DecorationImage(
              // fit: BoxFit.fill,
              image: AssetImage(
                ImagePath.appLogo,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
