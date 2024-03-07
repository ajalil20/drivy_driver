import 'package:drivy_driver/Service/navigation_service.dart';
import 'package:drivy_driver/Utils/app_router_name.dart';
import 'package:drivy_driver/Utils/image_path.dart';
import 'package:drivy_driver/Utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../../Component/custom_buttom.dart';
import '../../../../../Component/custom_text.dart';

class DeleteDialog extends StatelessWidget {
  DeleteDialog({super.key,required this.title,required this.subTitle,required this.onYes});
  String title,subTitle;
  Function onYes;
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.close_outlined,color: Colors.transparent,
                  ),
                  MyText(title: title,clr: MyColors().whiteColor,fontWeight: FontWeight.w600,),
                  GestureDetector(
                    onTap: (){AppNavigation.navigatorPop(context);},
                    child: Icon(
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
                  SizedBox(height: 2.h,),
                  Center(child: CircleAvatar(radius: 45, backgroundColor: MyColors().purpleColor,child:Image.asset(ImagePath.delete,scale: 3,color: MyColors().whiteColor,),)),
                  SizedBox(height: 2.h,),
                  Center(child: MyText(title: subTitle,clr: MyColors().black,size: 13,center: true,)),
                  SizedBox(height: 2.h,),
                  Row(
                    children: [
                      Flexible(
                        child: MyButton(
                            onTap: (){AppNavigation.navigatorPop(context);},
                            title: "No",bgColor: MyColors().purpleColor,
                        ),
                      ),
                      SizedBox(width: 5.w,),
                      Flexible(
                        child: MyButton(
                            onTap: (){AppNavigation.navigatorPop(context);
                              onYes();
                              },
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
