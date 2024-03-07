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

class SelectCarCategory extends StatefulWidget {
  const SelectCarCategory({super.key});

  @override
  State<SelectCarCategory> createState() => _SelectCarCategoryState();
}

class _SelectCarCategoryState extends State<SelectCarCategory> {
  MyColors colors = MyColors();
  RxString val= '85'.obs;
  List<MenuModel> methods =[
    MenuModel(name: 'Mini Cars',description: '2 nearby',value: '85'.obs, image: ImagePath.car1),
    MenuModel(name: 'Standard Cars',description: '1 nearby',value: '100'.obs, image: ImagePath.car2),
    MenuModel(name: 'Premium Cars',description: '5 nearby', value: '120'.obs, image: ImagePath.car3),
    MenuModel(name: 'Luxury Cars',description: '0 nearby',value: '200'.obs, image: ImagePath.car4),
  ];

  @override
  Widget build(BuildContext context) {
    return BaseView(
        screenTitle: "Select Car",
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
              MyText(title: 'Select vehicle category you want to ride.',size: 14,fontWeight: FontWeight.w600,),
              SizedBox(height: 3.h,),
              Expanded(
                child: ListView.builder(
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
                            Image.asset(methods[index].image!,scale: 2),
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
                            MyText(title: '${methods[index].value} AED'),
                            SizedBox(width: 3.w,),
                            Image.asset(
                              val.value==methods[index].value!.value?ImagePath.radioF:ImagePath.radioE,scale: 2,),
                          ],),
                      ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 3.h,),
              MyButton(title: 'Continue', onTap: (){
                AppNavigation.navigateTo(context, AppRouteName.PaymentSettings,arguments: ScreenArguments(fromRide: true));
              },),
              SizedBox(height:  3.h),

            ],
          ),
        )
    );
  }
}
