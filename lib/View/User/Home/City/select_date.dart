import 'package:drivy_user/Arguments/screen_arguments.dart';
import 'package:drivy_user/Component/custom_buttom.dart';
import 'package:drivy_user/Component/custom_calendar.dart';
import 'package:drivy_user/Component/custom_switch.dart';
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
import '../../../../Component/custom_text.dart';
import '../../../../Utils/image_path.dart';
import '../../../base_view.dart';

class SelectDate extends StatefulWidget {
  const SelectDate({super.key});

  @override
  State<SelectDate> createState() => _SelectDateState();
}

class _SelectDateState extends State<SelectDate> {
  MyColors colors = MyColors();
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
  bool delivery = false;

  @override
  Widget build(BuildContext context) {
    return BaseView(
        screenTitle: "Dubai to Sharjah",
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
                MyText(title:'Select your travel date ',size: 15,clr: MyColors().textColor,fontWeight: FontWeight.w600,),
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
                MyText(title:'Pick up',size: 15,clr: MyColors().textColor,fontWeight: FontWeight.w600,),
                SizedBox(height: 1.h,),
                Divider(),
                SizedBox(height: 1.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(title: 'Pick me up from Home',size: 14,),
                    CustomSwitch(switchValue: delivery.obs,onChange: (v){
                      setState(() {delivery=v;
                      });
                    },),
                  ],),
                SizedBox(height: 1.h,),
                Divider(),
                SizedBox(height: 2.h,),
                MyButton(title: 'Continue',onTap: (){
                  AppNavigation.navigateTo(context, AppRouteName.CheckoutCity);
                },),
                SizedBox(height:  3.h),

              ],
            ),
          ),
        )
    );
  }
}
