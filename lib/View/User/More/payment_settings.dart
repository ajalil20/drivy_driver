import 'package:drivy_user/Component/custom_buttom.dart';
import 'package:drivy_user/Component/custom_toast.dart';
import 'package:drivy_user/Service/navigation_service.dart';
import 'package:drivy_user/Utils/app_router_name.dart';
import 'package:flutter/material.dart';
import '../../../../../Utils/my_colors.dart';
import '../../../../../Utils/responsive.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import '../../../Component/custom_text.dart';
import '../../../Model/menu_model.dart';
import '../../../Utils/image_path.dart';
import '../../base_view.dart';

class PaymentSettings extends StatefulWidget {
  PaymentSettings({super.key,this.fromRide=false,this.fromRental=false});
  bool fromRide=false;
  bool fromRental=false;
  @override
  State<PaymentSettings> createState() => _PaymentSettingsState();
}

class _PaymentSettingsState extends State<PaymentSettings> {
  MyColors colors = MyColors();
  RxString val= '1'.obs;
  List<MenuModel> methods =[
    MenuModel(name: 'XXXX XXXX XXXX XX58',description: 'Valid May 2022',value: '1'.obs, image: ImagePath.visa),
    MenuModel(name: 'XXXX XXXX XXXX XX58',description: 'Valid May 2022',value: '2'.obs, image: ImagePath.masterCard),
    MenuModel(name: 'Google Pay',value: '3'.obs, image: ImagePath.g),
    MenuModel(name: 'Apple Pay',value: '4'.obs, image: ImagePath.a),
  ];

  @override
  Widget build(BuildContext context) {
    return BaseView(
        screenTitle: "Select Card",
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
              MyText(title: 'Select Payment Card',size: 14,fontWeight: FontWeight.w600,),
              SizedBox(height: 3.h,),
              ListView.builder(
                itemCount: methods.length,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (BuileContext, int index) {
                  return GestureDetector(
                    onTap: (){
                      val.value=methods[index].value!.value;
                    },
                    child: Obx(()=> Container(
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
                            Image.asset(methods[index].image!,scale: 2,width: 9.w,),
                            SizedBox(width: 3.w,),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText(title:methods[index].name!,size: 15,clr: Color(0xff4D5D65),fontWeight: FontWeight.w600,),
                                 if(methods[index].description!=null)...[
                                   SizedBox(height: .5.h,),
                                   MyText(title:methods[index].description??'',size: 15,clr: MyColors().greyColor,fontWeight: FontWeight.w500,),
                                 ],

                                ],
                              ),
                            ),
                            Image.asset(
                              val.value==methods[index].value!.value?ImagePath.radioF:ImagePath.radioE,scale: 2,),
                          ],),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 3.h,),
              GestureDetector(
                onTap: (){
                  AppNavigation.navigateTo(context, AppRouteName.ADD_CARD_ROUTE);
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Icon(Icons.add_box_rounded,color: MyColors().primaryColor,),
                  MyText(title: '  Add new card',clr: MyColors().greyColor,),
                ],),
              ),
              SizedBox(height:  3.h),
              if(widget.fromRide || widget.fromRental)...[
                Spacer(),
                MyButton(title: 'Continue', onTap: (){
                  AppNavigation.navigatorPop(context);
                  AppNavigation.navigatorPop(context);
                  if(widget.fromRental){
                    AppNavigation.navigatorPop(context);
                    AppNavigation.navigatorPop(context);
                    AppNavigation.navigatorPop(context);
                    CustomToast().showToast('Success', 'Your Payment has been Sent successfully!', false);
                  }
                },),
                SizedBox(height:  3.h),
              ],
            ],
          ),
        )
    );
  }
}
