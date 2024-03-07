import 'package:drivy_user/Arguments/screen_arguments.dart';
import 'package:drivy_user/Component/custom_buttom.dart';
import 'package:drivy_user/Model/menu_model.dart';
import 'package:drivy_user/Service/navigation_service.dart';
import 'package:drivy_user/Utils/app_router_name.dart';
import 'package:flutter/material.dart';
import '../../../../../Utils/my_colors.dart';
import '../../../../../Utils/responsive.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import '../../../../Component/custom_text.dart';
import '../../../../Utils/image_path.dart';
import '../../../base_view.dart';

class CityDetail extends StatelessWidget {
  CityDetail({super.key});
   RxString val= '85'.obs;
  List<MenuModel> methods =[
    MenuModel(name: 'Ford',description: 'Mercedes R200 2022',value: 'Active'.obs, image: ImagePath.rc),
    MenuModel(name: 'Ford',description: 'Mercedes R200 2022',value: 'Completed'.obs, image: ImagePath.rc),
    MenuModel(name: 'Ford',description: 'Mercedes R200 2022', value: 'Cancelled'.obs, image: ImagePath.rc),
    MenuModel(name: 'Ford',description: 'Mercedes R200 2022',value: 'Active'.obs, image: ImagePath.rc),
    MenuModel(name: 'Ford',description: 'Mercedes R200 2022',value: 'Completed'.obs, image: ImagePath.rc),
    MenuModel(name: 'Ford',description: 'Mercedes R200 2022', value: 'Cancelled'.obs, image: ImagePath.rc),
  ];

  @override
  Widget build(BuildContext context) {
    return BaseView(
        screenTitle: "Travel to Sharjah",
        showAppBar: true,
        centerTitle: false,
        showBackButton: true,
        resizeBottomInset: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 2.h,),
              Image.asset(ImagePath.random0,scale: 1,),
              SizedBox(height: 2.h,),
              MyText(title:'Description ',size: 15,clr: MyColors().textColor,fontWeight: FontWeight.w600,),
              SizedBox(height: 1.h,),
              MyText(title:'Lorem ipsum dolor sit amet consectetur. Nec purus faucibus augue congue donec nec at montes at. Quis suspendisse adipiscing diam felis. Non. ',size: 13,clr: MyColors().textColor,),
              SizedBox(height: 2.h,),
              MyText(title:'Select Vehicle Type ',size: 15,clr: MyColors().textColor,fontWeight: FontWeight.w600,),
              SizedBox(height: 1.h,),
              Row(children: [
                Image.asset(ImagePath.car2,scale: 2,),
                SizedBox(width: 3.w,),
                MyText(title:'Premium Cars',size: 14,clr: MyColors().textColor,fontWeight: FontWeight.w500,),
              ],),
              SizedBox(height: 2.h,),
              MyText(title:'Estimated Cost',size: 15,clr: MyColors().textColor,fontWeight: FontWeight.w600,),
              SizedBox(height: 1.h,),
              SizedBox(height: .8.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText(title: 'Platform Fee',clr: MyColors().hintColor,),
                  MyText(title: 'AED 1.55',clr: MyColors().hintColor,),
                ],),
              SizedBox(height: .8.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText(title: 'Saalik',clr: MyColors().hintColor,),
                  MyText(title: 'AED 1.96',clr: MyColors().hintColor,),
                ],),
              SizedBox(height: .8.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText(title: 'Subtotal',clr: MyColors().hintColor,),
                  MyText(title: 'AED 58.96',clr: MyColors().hintColor,),
                ],),
              SizedBox(height: .8.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText(title: 'Total',fontWeight: FontWeight.w600),
                  MyText(title: 'AED 62.55',fontWeight: FontWeight.w600),
                ],),
              SizedBox(height: 2.h,),
              Spacer(),
              MyButton(title: 'Continue',onTap: (){
                AppNavigation.navigateTo(context, AppRouteName.SelectDate);
              },),
              SizedBox(height:  3.h),

            ],
          ),
        )
    );
  }
}
