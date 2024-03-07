import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:drivy_user/Component/custom_buttom.dart';
import 'package:drivy_user/Component/custom_text.dart';
import 'package:drivy_user/Service/navigation_service.dart';
import 'package:drivy_user/Utils/my_colors.dart';
import 'package:drivy_user/Utils/utils.dart';
import 'package:sizer/sizer.dart';


class LogoutAlert extends StatefulWidget {
  @override
  State<LogoutAlert> createState() => _LogoutAlertState();
}

class _LogoutAlertState extends State<LogoutAlert> {
  @override
  Widget build(BuildContext c) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      // height: responsive.setHeight(75),
      width: 100.w,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: MyColors().purpleLight,borderRadius: const BorderRadius.vertical(top: Radius.circular(20))
              ),
              padding: EdgeInsets.symmetric(vertical: 2.h,horizontal: 3.w),
              margin: EdgeInsets.symmetric(vertical: 1.w,horizontal: 1.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.close_outlined,color: Colors.transparent,
                  ),
                  MyText(title: 'Logout Account',clr: MyColors().whiteColor,fontWeight: FontWeight.w600,),
                  GestureDetector(
                    onTap: (){AppNavigation.navigatorPop(c);},
                    child: const Icon(
                      Icons.close_outlined,color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),


            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // SizedBox(height: 2.h,),
                  // Center(child: CircleAvatar(radius: 45, backgroundColor: MyColors().purpleColor,child:Image.asset(ImagePath.delete,scale: 3,color: MyColors().whiteColor,),)),
                  SizedBox(height: 2.h,),
                  Center(child: MyText(title: 'Do you want logout of your account?',clr: MyColors().black,size: 13,center: true,)),
                  SizedBox(height: 2.h,),
                  Row(
                    children: [
                      Flexible(
                        child: MyButton(
                          onTap: (){AppNavigation.navigatorPop(c);},
                          title: "No",bgColor: MyColors().purpleColor,
                        ),
                      ),
                      SizedBox(width: 5.w,),
                      Flexible(
                        child: MyButton(
                            onTap: (){AppNavigation.navigatorPop(c);
                            Utils.logout(fromLogout: true,c: context);},
                            title: "Yes"
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 3.5.h,
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}