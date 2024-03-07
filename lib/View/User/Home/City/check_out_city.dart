import 'package:drivy_user/Arguments/screen_arguments.dart';
import 'package:drivy_user/Component/custom_buttom.dart';
import 'package:drivy_user/Component/custom_toast.dart';
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

class CheckoutCity extends StatefulWidget {
  const CheckoutCity({super.key});

  @override
  State<CheckoutCity> createState() => _CheckoutCityState();
}

class _CheckoutCityState extends State<CheckoutCity> {
  MyColors colors = MyColors();
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
        screenTitle: "Checkout",
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
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xffDAE1F1),
                  ),
                  borderRadius: BorderRadius.circular(20),
                  color: MyColors().whiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(ImagePath.random0,scale: 1,),
                    SizedBox(height: 1.5.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyText(title: 'AED 1000.00',size: 15,clr: MyColors().primaryColor,fontWeight: FontWeight.w600,),
                        Row(children: [
                          Icon(Icons.star_rounded,color: Color(0xffFBC400),),
                          SizedBox(width: 3.w),
                          MyText(
                            title: '4.8',
                            size: 12,
                            clr: MyColors().greyColor,
                            line: 1,
                            toverflow: TextOverflow.ellipsis,
                          ),
                        ],)
                      ],
                    ),
                    SizedBox(height: 1.h,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(title:'Atlantis Dubai ',size: 16,clr: MyColors().textColor),
                        Row(
                          children: [
                            Icon(Icons.location_on,color: MyColors().primaryColor,),
                            MyText(title:'Salahuddin Rd Deira, Dubai, Emirates ',size: 12,clr: MyColors().textColor),
                          ],
                        ),
                      ],
                    ),

                  ],),
              ),
              SizedBox(height: 2.h,),
              MyText(title:'Date & Time',size: 15,clr: MyColors().textColor,fontWeight: FontWeight.w600,),
              SizedBox(height: 1.h,),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xffDAE1F1),
                  ),
                  borderRadius: BorderRadius.circular(20),
                  color: MyColors().whiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                padding: EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                  Container(
                    decoration: BoxDecoration(
                      color: MyColors().black,
                      borderRadius: BorderRadius.circular(8)
                    ),
                    padding: EdgeInsets.all(8)+EdgeInsets.symmetric(horizontal: 8),
                    child: Column(children: [
                      Icon(Icons.calendar_month_rounded,color: MyColors().whiteColor,),
                      SizedBox(height: 1.h,),
                      MyText(title: 'Sun,Aug 8',clr: MyColors().whiteColor,)
                    ],),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: MyColors().black,
                        borderRadius: BorderRadius.circular(8)
                    ),
                    padding: EdgeInsets.all(8)+EdgeInsets.symmetric(horizontal: 8),
                    child: Column(children: [
                      Icon(Icons.schedule_rounded,color: MyColors().whiteColor,),
                      SizedBox(height: 1.h,),
                      MyText(title: '  9:00 am  ',clr: MyColors().whiteColor,)
                    ],),
                  ),
                ],)
              ),
              SizedBox(height: 2.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText(title:'Payment Method',size: 15,clr: MyColors().textColor,fontWeight: FontWeight.w600,),
                  MyText(title:'Change',size: 15,clr: MyColors().primaryColor,fontWeight: FontWeight.w600,under: true,),
                ],
              ),
              SizedBox(height: 1.h,),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xffDAE1F1),
                  ),
                  borderRadius: BorderRadius.circular(20),
                  color: MyColors().whiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                padding: EdgeInsets.all(12)+EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // MenuModel(name: 'XXXX XXXX XXXX XX58',description: 'Valid May 2022',value: '2'.obs, image: ImagePath.masterCard),

                    Image.asset( ImagePath.masterCard,scale: 2,width: 9.w,),
                    SizedBox(width: 3.w,),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(title:'XXXX XXXX XXXX XX58',size: 15,clr: Color(0xff4D5D65),fontWeight: FontWeight.w600,),
                          SizedBox(height: .5.h,),
                          MyText(title:'Valid May 2022',size: 15,clr: MyColors().greyColor,fontWeight: FontWeight.w500,),
                        ],
                      ),
                    ),
                  ],),
              ),
              // Container(
              //     decoration: BoxDecoration(
              //       border: Border.all(
              //         color: Color(0xffDAE1F1),
              //       ),
              //       borderRadius: BorderRadius.circular(20),
              //       color: MyColors().whiteColor,
              //       boxShadow: [
              //         BoxShadow(
              //           color: Colors.grey.withOpacity(0.1),
              //           spreadRadius: 5,
              //           blurRadius: 7,
              //           offset: Offset(0, 3), // changes position of shadow
              //         ),
              //       ],
              //     ),
              //     padding: EdgeInsets.all(12),
              //     child:
              // ),

              SizedBox(height: 2.h,),
              MyText(title:'Order Summary',size: 15,clr: MyColors().textColor,fontWeight: FontWeight.w600,),
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
                  MyText(title: 'Sales tax',clr: MyColors().hintColor,),
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
              MyButton(title: 'Checkout',onTap: (){
                AppNavigation.navigatorPop(context);
                AppNavigation.navigatorPop(context);
                AppNavigation.navigatorPop(context);
                AppNavigation.navigatorPop(context);
                CustomToast().showToast('Success','Your booking has been placed successfully!', false);
              },),
              SizedBox(height:  3.h),

            ],
          ),
        )
    );
  }
}
