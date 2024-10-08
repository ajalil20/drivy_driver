import 'package:drivy_driver/Arguments/screen_arguments.dart';
import 'package:drivy_driver/Component/custom_buttom.dart';
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

class RentalBookingDetail extends StatelessWidget {
  RentalBookingDetail({super.key});

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
                          MyText(title: 'Schedule Date',fontWeight: FontWeight.w400,),
                          MyText(title: '06 April 2024',fontWeight: FontWeight.w600,),
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(child: MyText(title: 'Mande Portman',fontWeight: FontWeight.w700,line: 1,)),
                                SizedBox(width: 3.w),

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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Row(children: [
                                    Icon(Icons.star_rounded,color: Color(0xffFBC400),),
                                    SizedBox(width: 1.w),
                                    MyText(
                                      title: '4.8',
                                      size: 12,
                                      clr: MyColors().greyColor,
                                      line: 1,
                                      toverflow: TextOverflow.ellipsis,
                                    ),
                                  ],),
                                ),
                                Image.asset(ImagePath.call,scale: 2,),
                                SizedBox(width: 3.w,),
                                Image.asset(ImagePath.chat3,scale: 2,),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2.h,),
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
                MyText(title:'Pick & Drop Location',size: 15,clr: MyColors().textColor,fontWeight: FontWeight.w600,),
                SizedBox(height: 1.h,),
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
                    children: [
                      Container(padding: EdgeInsets.all(3.3.w),decoration: BoxDecoration(
                          color: MyColors().primaryColor.withOpacity(.1),
                          borderRadius: BorderRadius.circular(7)
                      ),child: Image.asset(ImagePath.location,scale: 2,), ),
                      SizedBox(width: 3.w,),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText(title:'Kadin Gouse',size: 15,fontWeight: FontWeight.w600,),
                            SizedBox(height: .5.h,),
                            MyText(title:'Box No.27785, Salahuddin Rd Deira, Dubai, Emirates ',size: 13,clr:MyColors().greyColor),
                          ],
                        ),
                      ),
                      SizedBox(width: 3.w,),
                    ],
                  ),
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
                  child: Column(children: [
                    MyText(title:'Extra Charge',size: 15,clr: MyColors().textColor,fontWeight: FontWeight.w600,),
                    SizedBox(height: 1.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyText(title: 'Status',fontWeight: FontWeight.w500),
                        MyText(title: 'Unpaid',clr: MyColors().errorColor,fontWeight: FontWeight.w600,),
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
                    SizedBox(height: 1.h,),
                    MyButton(title: 'Pay Now',height: 5.h,width: 50.w,onTap: (){
                      AppNavigation.navigateTo(context, AppRouteName.PaymentSettings);
                    },),
                  ],),
                ),
                SizedBox(height: 2.h,),
                MyText(title:'Order Summary',size: 15,clr: MyColors().textColor,fontWeight: FontWeight.w600,),
                SizedBox(height: 1.h,),
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
                MyButton(title: 'Dispute',onTap: (){
                  AppNavigation.navigateTo(context, AppRouteName.HelpSupport);
                },bgColor: MyColors().whiteColor,borderColor: MyColors().primaryColor,textColor: MyColors().primaryColor,),
                SizedBox(height: 2.h,),
                MyText(title: 'Lorem ipsum dolor sit amet consectetur. Pulvinar posuere vel nec mauris. Quam non neque nisi duis egestas ultricies. Egestas in proin.',clr: MyColors().errorColor,size: 12,),
                SizedBox(height: 2.h,),

              ],
            ),
          ),
        )
    );
  }
}
