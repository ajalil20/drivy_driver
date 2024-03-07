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
import '../../../base_view.dart';

class SelectCar extends StatefulWidget {
  const SelectCar({super.key});

  @override
  State<SelectCar> createState() => _SelectCarState();
}

class _SelectCarState extends State<SelectCar> {
  MyColors colors = MyColors();
  RxString val= '85'.obs;
  List<MenuModel> methods =[
    MenuModel(name: 'Ford',description: 'Mercedes R200 2022',value: '85'.obs, image: ImagePath.rc),
    MenuModel(name: 'Ford',description: 'Mercedes R200 2022',value: '100'.obs, image: ImagePath.rc),
    MenuModel(name: 'Ford',description: 'Mercedes R200 2022', value: '120'.obs, image: ImagePath.rc),
    MenuModel(name: 'Ford',description: 'Mercedes R200 2022',value: '200'.obs, image: ImagePath.rc),
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
                                  MyText(title:methods[index].name!,size: 13,clr:MyColors().primaryColor,fontWeight: FontWeight.w600,),
                                  SizedBox(height: .5.h,),
                                  MyText(title:methods[index].description??'',size: 15,clr: MyColors().greyColor,fontWeight: FontWeight.w600,),
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
              GestureDetector(
                onTap: (){
                  AppNavigation.navigateTo(context, AppRouteName.AddCar);
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_box_rounded,color: MyColors().primaryColor,),
                    MyText(title: '  Add new car',clr: MyColors().greyColor,),
                  ],),
              ),
              SizedBox(height: 3.h,),
              MyButton(title: 'Continue', onTap: (){
                AppNavigation.navigateTo(context, AppRouteName.Ride);
              },),
              SizedBox(height:  3.h),

            ],
          ),
        )
    );
  }
}
