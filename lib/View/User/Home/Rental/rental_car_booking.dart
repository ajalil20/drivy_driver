import 'package:drivy_user/Arguments/screen_arguments.dart';
import 'package:drivy_user/Component/custom_buttom.dart';
import 'package:drivy_user/Component/custom_calendar.dart';
import 'package:drivy_user/Component/custom_textfield.dart';
import 'package:drivy_user/Model/menu_model.dart';
import 'package:drivy_user/Service/navigation_service.dart';
import 'package:drivy_user/Utils/app_router_name.dart';
import 'package:drivy_user/Utils/utils.dart';
import 'package:flutter/material.dart';
import '../../../../../Utils/my_colors.dart';
import '../../../../../Utils/responsive.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import '../../../../Component/custom_switch.dart';
import '../../../../Component/custom_text.dart';
import '../../../../Utils/image_path.dart';
import '../../../base_view.dart';

class CityCarBooking extends StatefulWidget {
  const CityCarBooking({super.key});

  @override
  State<CityCarBooking> createState() => _CityCarBookingState();
}

class _CityCarBookingState extends State<CityCarBooking> {
  bool delivery = false;
  RxString val= '85'.obs;
  TextEditingController time = TextEditingController();
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
        screenTitle: "Booking",
        showAppBar: true,
        centerTitle: false,
        showBackButton: true,
        resizeBottomInset: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 2.h,),
                MyText(title:'Start & End Date',size: 15,clr: MyColors().textColor,fontWeight: FontWeight.w600,),
                SizedBox(height: 1.h,),
                MyCalendar(
                  selectedDay:(v) async{},
                ),
                SizedBox(height: 2.h,),
                MyText(title:'Select your time',size: 15,clr: MyColors().textColor,fontWeight: FontWeight.w600,),
                SizedBox(height: 1.h,),
                MyTextField(
                  controller: time,
                  backgroundColor: MyColors().primaryColor.withOpacity(.4),
                  hintText: '09:00 AM',
                  hintTextColor: MyColors().primaryColor,
                  textColor: MyColors().primaryColor,
                  maxLength: 30,
                  readOnly: true,
                  suffixIconData: Icon(Icons.keyboard_arrow_down_rounded,size: 25,color: Colors.black,),
                  onTap: () async{
                    FocusManager.instance.primaryFocus?.unfocus();
                    time.text = await Utils().selectTime(context,onTap: (v){
                      // et=Utils().convertTimeToMinutes(h: v.hour, m: v.minute);
                    });
                  },
                  // suffixIcons: Icon(Icons.keyboard_arrow_down_rounded,size: 20,color: Colors.black,),
                ),
                SizedBox(height: 2.h,),
                MyTextField(
                  controller: time,
                  backgroundColor: MyColors().primaryColor.withOpacity(.4),
                  hintText: 'Additional Services',
                  hintTextColor: MyColors().primaryColor,
                  textColor: MyColors().primaryColor,
                  maxLength: 30,
                  readOnly: true,
                  suffixIconData: Icon(Icons.keyboard_arrow_right_rounded,size: 25,color: Colors.black,),
                  onTap: () async{
                   AppNavigation.navigateTo(context, AppRouteName.AdditionalService);
                  },
                  // suffixIcons: Icon(Icons.keyboard_arrow_down_rounded,size: 20,color: Colors.black,),
                ),
                SizedBox(height: 2.h,),
                MyText(title:'Delivery',size: 15,clr: MyColors().textColor,fontWeight: FontWeight.w600,),
                SizedBox(height: 1.h,),
                Divider(),
                SizedBox(height: 1.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(title: 'Get the car delivered directly to you',size: 14,),
                    CustomSwitch(switchValue: delivery.obs,onChange: (v){
                      setState(() {delivery=v;
                      });
                    },),
                  ],),
                SizedBox(height: 1.h,),
                Divider(),
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
                MyButton(title: 'Continue',onTap: (){
                  AppNavigation.navigateTo(context, AppRouteName.RentalCarCheckout);
                },),
                SizedBox(height:  3.h),

              ],
            ),
          ),
        )
    );
  }
}
