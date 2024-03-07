import 'package:drivy_user/Component/custom_toast.dart';
import 'package:drivy_user/Service/navigation_service.dart';
import 'package:drivy_user/Utils/app_router_name.dart';
import 'package:drivy_user/Utils/image_path.dart';
import 'package:drivy_user/Utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:drivy_user/Utils/utils.dart';
import 'package:sizer/sizer.dart';
import '../../../../../Component/custom_buttom.dart';
import '../../../../../Component/custom_text.dart';

class ProfileUpdateDialog extends StatelessWidget {
  bool editProfile;
  ProfileUpdateDialog({super.key,this.editProfile = false});
  @override
  Widget build(BuildContext context) {
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
                color: MyColors().purpleLight,borderRadius: BorderRadius.vertical(top: Radius.circular(20))
              ),
              padding: EdgeInsets.symmetric(vertical: 2.h,horizontal: 3.w),
              margin: EdgeInsets.symmetric(vertical: 1.w,horizontal: 1.w),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon(
                  //   Icons.close_outlined,color: Colors.transparent,
                  // ),
                  MyText(title: 'Successful',clr: MyColors().whiteColor,fontWeight: FontWeight.w600,),
                  // GestureDetector(
                  //   onTap: (){AppNavigation.navigatorPop(context);},
                  //   child: Icon(
                  //     Icons.close_outlined,color: Colors.white,
                  //   ),
                  // ),
                ],
              ),
            ),


            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 2.h,),
                  Center(child: CircleAvatar(radius: 45, backgroundColor: MyColors().greenColor,child:Image.asset(ImagePath.tickIcon,scale: 5,),)),
                  SizedBox(height: 2.h,),
                  MyText(title: 'Your profile has been ${editProfile? 'updated': 'created'} successfully.',clr: MyColors().black,size: 13,center: true,),
                  SizedBox(height: 2.h,),
                  MyButton(
                      onTap: (){
                        if(editProfile){
                          AppNavigation.navigatorPop(context);
                          AppNavigation.navigatorPop(context);
                        }else{
                          Utils().connectSocket(onConnect: (){});
                          // CustomToast().showToast("Success", "Signup Successfully", false);
                          AppNavigation.navigateTo(context, AppRouteName.HOME_SCREEN_ROUTE,);
                        }
                        },
                      title: "Continue"
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
