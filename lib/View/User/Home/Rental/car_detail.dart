import 'package:drivy_user/Arguments/screen_arguments.dart';
import 'package:drivy_user/Component/custom_buttom.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:drivy_user/Model/menu_model.dart';
import 'package:drivy_user/Service/navigation_service.dart';
import 'package:drivy_user/Utils/app_router_name.dart';
import 'package:flutter/material.dart';
import '../../../../../Utils/my_colors.dart';
import '../../../../../Utils/responsive.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import '../../../../Component/custom_image.dart';
import '../../../../Component/custom_text.dart';
import '../../../../Component/custom_textfield.dart';
import '../../../../Utils/image_path.dart';
import '../../../base_view.dart';

class CarDetail extends StatefulWidget {
  const CarDetail({super.key});

  @override
  State<CarDetail> createState() => _CarDetailState();
}

class _CarDetailState extends State<CarDetail> {
  MyColors colors = MyColors();
  RxString val= '85'.obs;
  List<MenuModel> methods =[
    MenuModel(name: 'Drive',description: 'Automatic',value: '85'.obs, image: ImagePath.drive),
    MenuModel(name: 'Seats',description: '5 Seats',value: '100'.obs, image: ImagePath.seat),
    MenuModel(name: 'Fuel',description: 'Diesel', value: '120'.obs, image: ImagePath.fuel),
  ];
  List<MenuModel> features =[
    MenuModel(name: 'Bluetooth', image: ImagePath.bluetooth),
    MenuModel(name: 'GPS', image: ImagePath.gps),
    MenuModel(name: 'Backup camera', image: ImagePath.bcam),
    MenuModel(name: 'USB input', image: ImagePath.usb),
    MenuModel(name: 'Blind spot warning', image: ImagePath.blind),
    MenuModel(name: 'USB charger', image: ImagePath.charger),
 ];

  @override
  Widget build(BuildContext context) {
    return BaseView(
        screenTitle: "",
        showAppBar: true,
        centerTitle: false,
        showBackButton: true,
        resizeBottomInset: false,
        trailingAppBar: Image.asset(ImagePath.heartF,scale: 2,),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 2.h,),
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
                              Expanded(child: MyText(title: 'Daniel Austin',fontWeight: FontWeight.w700,line: 1,)),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(ImagePath.rc1,scale: 2,),
                    SizedBox(width: 2.w,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(title: 'S 500 Sedan',size: 15,clr: MyColors().textColor2,fontWeight: FontWeight.w600,),
                          MyText(title:'Egestas nisi rutrum interdum pretium integer amet integer. Sollicitudin molestie mattis dui pharetra sed sed rhoncus dui tempor. Ullamcorper bibendum blandit tempor porttitor lorem lectus sit at egestas. Commodo justo dolor aenean ut libero nisi vitae quis. At dui non et ipsum. ',clr: MyColors().hintColor,line: 2,),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h,),
                MyText(title:'Car Specs',size: 15,clr: MyColors().textColor,fontWeight: FontWeight.w600,),
                SizedBox(height: 1.h,),
                Container(
                  height: 6.6.h,
                  width: 100.w,
                  alignment: Alignment.centerLeft,
                  child: ListView.builder(
                    itemCount: methods.length,
                    shrinkWrap: false,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (BuileContext, int index) {
                      return GestureDetector(
                        onTap: (){
                          val.value=methods[index].value!.value;
                          AppNavigation.navigateTo(context, AppRouteName.CarDetail);
                        },
                        child: Container(
                          width: 32.w,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xffDAE1F1),
                            ),
                            borderRadius: BorderRadius.circular(12),
                            color: MyColors().whiteColor,
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: Colors.grey.withOpacity(0.1),
                            //     spreadRadius: 5,
                            //     blurRadius: 7,
                            //     offset: Offset(0, 3), // changes position of shadow
                            //   ),
                            // ],
                          ),
                          padding: EdgeInsets.all(12),
                          margin: EdgeInsets.only(right: 3.w),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(methods[index].image!,scale: 2,),
                              SizedBox(width: 2.w,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText(title: methods[index].name!,size: 15,clr: MyColors().textColor2,fontWeight: FontWeight.w600,),
                                  MyText(title:methods[index].description!,clr: MyColors().hintColor,line: 2,),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 2.h,),
                MyTextField(
                  // controller: time,
                  backgroundColor: MyColors().primaryColor.withOpacity(.4),
                  hintText: 'Availability',
                  hintTextColor: MyColors().primaryColor,
                  textColor: MyColors().primaryColor,
                  maxLength: 30,
                  readOnly: true,
                  suffixIconData: Icon(Icons.keyboard_arrow_down_rounded,size: 25,color: Colors.black,),
                  onTap: () async{
                    AppNavigation.navigateTo(context, AppRouteName.Availability);
                  },
                  // suffixIcons: Icon(Icons.keyboard_arrow_down_rounded,size: 20,color: Colors.black,),
                ),
                SizedBox(height: 2.h,),
                MyTextField(
                  // controller: time,
                  backgroundColor: MyColors().primaryColor.withOpacity(.4),
                  hintText: 'Rules',
                  hintTextColor: MyColors().primaryColor,
                  textColor: MyColors().primaryColor,
                  maxLength: 30,
                  readOnly: true,
                  suffixIconData: Icon(Icons.keyboard_arrow_down_rounded,size: 25,color: Colors.black,),
                  onTap: () async{
                    AppNavigation.navigateTo(context, AppRouteName.Rules);
                  },
                  // suffixIcons: Icon(Icons.keyboard_arrow_down_rounded,size: 20,color: Colors.black,),
                ),
                SizedBox(height: 2.h,),
                MyText(title:'Features',size: 15,clr: MyColors().textColor,fontWeight: FontWeight.w600,),
                SizedBox(height: 1.h,),
                GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 3,crossAxisSpacing: 3.w,mainAxisSpacing: 3.w,),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: features.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xffDAE1F1),
                          ),
                          borderRadius: BorderRadius.circular(20),
                          color: MyColors().whiteColor,
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Colors.grey.withOpacity(0.1),
                          //     spreadRadius: 5,
                          //     blurRadius: 7,
                          //     offset: Offset(0, 3), // changes position of shadow
                          //   ),
                          // ],
                        ),
                        padding: EdgeInsets.all(12),
                        // margin: EdgeInsets.only(right: 3.w,top: 1.h,bottom: 1.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(features[index].image!,scale: 2,),
                            SizedBox(width: 2.w,),
                            Expanded(child: MyText(title: features[index].name!,size: 15,clr: MyColors().textColor2,fontWeight: FontWeight.w600,)),
                          ],
                        ),
                      );
                    }),
                SizedBox(height: 2.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  RichText(
                    textAlign: TextAlign.center,
                    textScaleFactor: 1.03,
                    text: TextSpan(
                      text: 'AED 80  ',
                      style: GoogleFonts.inter(
                        color: MyColors().black,
                        fontWeight: FontWeight.w600,
                        fontSize: 15
                      ),
                      children: [
                        TextSpan(
                          text: '/ day',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            color: MyColors().hintColor,
                            fontSize: 12
                          ),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(width: 10.w,),
                  Flexible(child: MyButton(title: 'Continue',onTap: (){
                    AppNavigation.navigateTo(context, AppRouteName.CityCarBooking);
                  },width: 30.w,height: 5.h,))
                ],),
                SizedBox(height: 2.h,),
              ],),
          ),
        )
    );
  }
}
