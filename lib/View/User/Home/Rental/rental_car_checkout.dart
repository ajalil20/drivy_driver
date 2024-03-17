import 'package:drivy_driver/Arguments/screen_arguments.dart';
import 'package:drivy_driver/Component/custom_buttom.dart';
import 'package:drivy_driver/Component/custom_image.dart';
import 'package:drivy_driver/Component/custom_toast.dart';
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
import '../../../base_view.dart';

class RentalCarCheckout extends StatefulWidget {
  const RentalCarCheckout({super.key});

  @override
  State<RentalCarCheckout> createState() => _RentalCarCheckoutState();
}

class _RentalCarCheckoutState extends State<RentalCarCheckout> {
  MyColors colors = MyColors();
  RxString val= '85'.obs;
  List<MenuModel> methods =[
    MenuModel(name: 'Car wash',description: 'Mercedes R200 2022',value: 'Active'.obs, image: ImagePath.wash),
    MenuModel(name: 'Pre-paid fuel',description: 'Mercedes R200 2022',value: 'Completed'.obs, image: ImagePath.tool),
    MenuModel(name: 'Additional equipment',description: 'Mercedes R200 2022', value: 'Cancelled'.obs, image: ImagePath.fuel2),
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
                  margin: EdgeInsets.only(bottom: 2.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 2.8.h,
                            backgroundColor: MyColors().whiteColor,
                            child: CustomImage(
                              height: 6.h,
                              width: 6.h,
                              isProfile: true,
                              photoView: false,
                              // url: c.user?.userImage,
                              radius: 100,
                            ),
                          ),
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
                                    SizedBox(width: 3.w),
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
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 100.w,height: 20.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                                image: AssetImage(ImagePath.rc,),
                                fit: BoxFit.cover
                            )
                        ),
                        alignment: Alignment.topRight,
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: MyColors().whiteColor
                            ),
                            margin: EdgeInsets.only(top: 1.h,right: 1.h),
                            padding: EdgeInsets.all(6),
                            child: Image.asset(ImagePath.heartF,scale: 2,)
                        ),
                      ),
                      // Image.asset(ImagePath.rc,scale: 1,fit: BoxFit.cover,width: 100.w,height: 20.h,),
                      SizedBox(height: 1.5.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyText(title: 'Sat, 26th Apr 9:00 PM',size: 13,clr: MyColors().primaryColor,fontWeight: FontWeight.w600,),
                              MyText(title: 'Ford R200 2022',size: 15,clr: MyColors().textColor2,fontWeight: FontWeight.w600,),
                            ],
                          ),
                          Flexible(child: MyButton(title: 'AED 120/day',height: 5.h,width: 40.w,radius: 25,))
                        ],
                      ),

                      SizedBox(height: 1.h,),
                      MyText(title:'Egestas nisi rutrum interdum pretium integer amet integer. Sollicitudin molestie mattis dui pharetra sed sed rhoncus dui tempor. Ullamcorper bibendum blandit tempor porttitor lorem lectus sit at egestas. Commodo justo dolor aenean ut libero nisi vitae quis. At dui non et ipsum. ',clr: MyColors().textColor),

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
                      children: [
                        Image.asset(ImagePath.map,scale: 1,),
                        SizedBox(height: 1.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyText(title: 'Pickup Location',size: 15,fontWeight: FontWeight.w600,),
                                MyText(title: 'Lorem ipsum dolor sit amet...',size: 13,clr: MyColors().greyColor),
                              ],
                            ),
                            Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: MyColors().primaryColor
                                ),
                                margin: EdgeInsets.only(top: 1.h,right: 1.h),
                                padding: EdgeInsets.all(8)+EdgeInsets.only(right: 3),
                                child: Image.asset(ImagePath.sendMessage,scale: 2,color: MyColors().whiteColor,)
                            ),
                          ],
                        ),
                      ],
                    )
                ),
                SizedBox(height: 2.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(title:'Additional Services',size: 15,clr: MyColors().textColor,fontWeight: FontWeight.w600,),
                    MyText(title:'Change',size: 15,clr: MyColors().primaryColor,fontWeight: FontWeight.w600,under: true,),
                  ],
                ),
                SizedBox(height: 1.h,),
                ListView.builder(
                  itemCount: methods.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuileContext, int index) {
                    return GestureDetector(
                      onTap: (){
                        val.value=methods[index].value!.value;
                      },
                      child:Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: MyColors().primaryColor,
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
                        margin: EdgeInsets.only(bottom: 1.5.h),
                        padding: EdgeInsets.all(12)+EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(methods[index].image!,scale: 2,width: 9.w,),
                            SizedBox(width: 3.w,),
                            Expanded(child: MyText(title:methods[index].name!,size: 15,clr: MyColors().primaryColor,fontWeight: FontWeight.w600,)),
                            MyText(title:'AED 85',size: 15,clr: MyColors().primaryColor)
                          ],),
                      ),
                    );
                  },
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
                // Spacer(),
                MyButton(title: 'Checkout',onTap: (){
                  AppNavigation.navigateTo(context, AppRouteName.PaymentSettings,arguments: ScreenArguments(fromRental: true));
                  // AppNavigation.navigateTo(context, AppRouteName.PaymentSettings);
                  // AppNavigation.navigatorPop(context);
                  // AppNavigation.navigatorPop(context);
                  // AppNavigation.navigatorPop(context);
                  // AppNavigation.navigatorPop(context);
                  // CustomToast().showToast('Success','Your booking has been placed successfully!', false);
                },),
                SizedBox(height:  3.h),

              ],
            ),
          ),
        )
    );
  }
}
