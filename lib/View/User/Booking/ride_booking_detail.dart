import 'package:drivy_driver/Arguments/screen_arguments.dart';
import 'package:drivy_driver/Component/custom_buttom.dart';
import 'package:drivy_driver/Component/custom_image.dart';
import 'package:drivy_driver/Model/menu_model.dart';
import 'package:drivy_driver/Service/navigation_service.dart';
import 'package:drivy_driver/Utils/app_router_name.dart';
import 'package:flutter/material.dart';
import '../../../../../Utils/my_colors.dart';
import '../../../../../Utils/responsive.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import '../../../../Component/custom_text.dart';
import '../../../../Utils/image_path.dart';
import '../../base_view.dart';

class RideBookingDetail extends StatelessWidget {
  RideBookingDetail({super.key,required this.fromRide});
  bool fromRide;
  @override
  Widget build(BuildContext context) {
    return BaseView(
        screenTitle: "Booking Detail",
        showAppBar: true,
        centerTitle: false,
        showBackButton: true,
        resizeBottomInset: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 2.h,),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xffDAE1F1),
                    ),
                    borderRadius: BorderRadius.circular(8),
                    color: MyColors().hintColor.withOpacity(.1),
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

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  MyText(title: 'Booking ID  ',size: 15,clr: MyColors().greyColor,fontWeight: FontWeight.w600,),
                                  MyText(title: '#587456',size: 15,clr: MyColors().black,fontWeight: FontWeight.w600,),
                                ],
                              ),
                              SizedBox(height: .5.h,),
                              MyText(title: 'Placed on 25 Dec, 08:00PM',size: 12,clr: MyColors().greyColor,fontWeight: FontWeight.w500,),
                            ],
                          ),
                          MyText(title: 'Completed',size: 12,clr:MyColors().greenColor,
                          ),
                        ],
                      ),
                      SizedBox(height: 1.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(title: 'Service',fontWeight: FontWeight.w400,),
                          MyText(title: fromRide?'Standard car':'Pay per minute',fontWeight: FontWeight.w600,),
                        ],),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(title: 'Schedule Time',fontWeight: FontWeight.w400,),
                          MyText(title: '10:00PM',fontWeight: FontWeight.w600,),
                        ],),

                    ],),
                ),
                SizedBox(height: 2.h,),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xffDAE1F1),
                    ),
                    borderRadius: BorderRadius.circular(8),
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(ImagePath.marker,scale: 2,),
                      // CircleAvatar(
                      //   radius: 2.8.h,
                      //   backgroundColor: MyColors().whiteColor,
                      //   child: CustomImage(
                      //     height: 6.h,
                      //     width: 6.h,
                      //     isProfile: true,
                      //     photoView: false,
                      //     // url: c.user?.userImage,
                      //     radius: 100,
                      //   ),
                      // ),
                      SizedBox(width : 2.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(child: MyText(title: 'Marilyn Lipshutz',fontWeight: FontWeight.w700,line: 1,)),
                                SizedBox(width: 3.w),
                                Icon(Icons.star_rounded,color: Color(0xffFBC400),),
                                SizedBox(width: 1.w),
                                MyText(
                                  title: '4.8',
                                  size: 12,
                                  clr: MyColors().greyColor,
                                  line: 1,
                                  toverflow: TextOverflow.ellipsis,
                                ),
                                // MyText(
                                //   title: Utils.relativeTime(c.createdAt),
                                //   size: 12,
                                //   clr: MyColors().greyColor,
                                //   line: 1,
                                //   toverflow: TextOverflow.ellipsis,
                                // ),
                              ],
                            ),
                            // SizedBox(height: .5.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MyText(
                                  title: fromRide? 'Mercedes-Benz E-class':'Chauffeur',
                                  size: 12,
                                  clr: MyColors().greyColor,
                                  line: 1,
                                  toverflow: TextOverflow.ellipsis,
                                ),
                                if(fromRide)
                                MyText(
                                  title: 'HSW 7345 XK',
                                  size: 12,
                                  clr: MyColors().greyColor,
                                  line: 1,
                                  fontWeight: FontWeight.w600,
                                  toverflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2.h,),
                if(!fromRide)...[
                  Container(
                    decoration: BoxDecoration(
                      // border: Border.all(
                      //   color: Color(0xffDAE1F1).withOpacity(.3),
                      // ),
                      borderRadius: BorderRadius.circular(8),
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
                    margin: EdgeInsets.only(bottom: 1.5.h),
                    padding: EdgeInsets.all(12)+EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(ImagePath.rc,scale: 2),
                        SizedBox(width: 3.w,),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyText(title:'Mercedes R200 2022',size: 15,clr: MyColors().greyColor,fontWeight: FontWeight.w600,),
                              SizedBox(height: .5.h,),
                              MyText(title:'Mercedes',size: 13,clr:MyColors().primaryColor,fontWeight: FontWeight.w600,),
                            ],
                          ),
                        ),
                        SizedBox(width: 3.w,),
                      ],),
                  ),
                  SizedBox(height: 2.h,),
                ],
                MyText(title:'Location',size: 15,clr: MyColors().textColor,fontWeight: FontWeight.w600,),
                SizedBox(height: 1.h,),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xffDAE1F1),
                    ),
                    borderRadius: BorderRadius.circular(8),
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
                  child: Column(children: [
                    Row(children: [
                      Image.asset(ImagePath.source,scale: 2,),
                      SizedBox(width: 2.w,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(title: 'My Current Location',fontWeight: FontWeight.w600,size: 15,),
                          MyText(title: '35 Oak Ave. Antioch, TN 3456',clr: MyColors().greyColor,),
                        ],
                      ),
                    ],),
                    SizedBox(height: 2.h,),
                    Row(children: [
                      Image.asset(ImagePath.destination,scale: 2,),
                      SizedBox(width: 2.w,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(title: 'Soft Bank Buildings',fontWeight: FontWeight.w600,size: 15,),
                          MyText(title: '25 State St. Daphne, Al 3456',clr: MyColors().greyColor,),
                        ],
                      ),
                    ],),
                  ],),
                ),
                SizedBox(height: 2.h,),
                MyText(title:'Payment Method',size: 15,clr: MyColors().textColor,fontWeight: FontWeight.w600,),
                SizedBox(height: 1.h,),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xffDAE1F1),
                    ),
                    borderRadius: BorderRadius.circular(12),
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
                // MyButton(title: 'Give Rating',onTap: (){
                //   // AppNavigation.navigateTo(context, AppRouteName.RateBooking);
                // },bgColor: MyColors().whiteColor,borderColor: MyColors().primaryColor,textColor: MyColors().primaryColor,),
                // SizedBox(height: 2.h,),

              ],
            ),
          ),
        )
    );
  }
}
