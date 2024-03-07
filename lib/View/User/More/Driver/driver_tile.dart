import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:drivy_driver/Component/custom_buttom.dart';
import 'package:drivy_driver/Component/custom_empty_data.dart';
import 'package:drivy_driver/Component/custom_image.dart';
import 'package:drivy_driver/Component/custom_padding.dart';
import 'package:drivy_driver/Component/custom_refresh.dart';
import 'package:drivy_driver/Controller/home_controller.dart';
import 'package:drivy_driver/Model/category_product_model.dart';
import 'package:drivy_driver/Service/navigation_service.dart';
import 'package:drivy_driver/Utils/app_router_name.dart';
import 'package:drivy_driver/Utils/image_path.dart';
import 'package:drivy_driver/Utils/my_colors.dart';
import 'package:drivy_driver/View/Widget/counter.dart';
import 'package:drivy_driver/View/base_view.dart';
import '../../../../../Component/custom_text.dart';
import 'package:sizer/sizer.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DriverTile extends StatelessWidget {
  DriverTile({super.key,required this.onTap});
  Function onTap;
  RxBool f = false.obs;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        builder: (d) {
        return GestureDetector(
          onTap: (){
            // HomeController.i.getProductDetail(context,p: p);
            // AppNavigation.navigateTo(context, AppRouteName.PRODUCT_DETAIL_ROUTE);
          },
          child: Container(
            // decoration: BoxDecoration(
            //   border: Border.all(
            //     color: Color(0xffDAE1F1),
            //   ),
            //   borderRadius: BorderRadius.circular(10),
            //   color: MyColors().whiteColor,
            //   boxShadow: [
            //     BoxShadow(
            //       color: Colors.grey.withOpacity(0.1),
            //       spreadRadius: 5,
            //       blurRadius: 7,
            //       offset: Offset(0, 3), // changes position of shadow
            //     ),
            //   ],
            // ),
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                CircleAvatar(
                  radius:3.0.h,
                  backgroundColor: MyColors().primaryColor,
                  child: CustomImage(
                    height: 6.5.h,
                    width: 6.5.h,
                    isProfile: true,
                    photoView: false,
                    // url: u.value.userImage,
                    radius: 100,
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(title:'Alfonso Rosser',size: 14,clr: MyColors().textColor,fontWeight: FontWeight.w600,),
                      SizedBox(height: 1.h,),
                      MyText(title:'Mercedes-Benz E-class',size: 12,clr: MyColors().greyColor),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                        onTap: (){
                          f.value=!f.value;
                          d.update();
                        },
                        child: Image.asset(f.isTrue? ImagePath.heartF:ImagePath.heartE,scale: 2,)),
                    SizedBox(height: 1.h,),
                    MyText(title:'HSW 7345 XK',size: 12,clr: MyColors().greyColor),
                  ],
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
