
import 'dart:io';

import 'package:drivy_driver/Arguments/screen_arguments.dart';
import 'package:drivy_driver/Component/Appbar/appbar_components.dart';
import 'package:drivy_driver/Model/menu_model.dart';
import 'package:drivy_driver/Service/navigation_service.dart';
import 'package:drivy_driver/Utils/app_router_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:sizer/sizer.dart';
import '../../../../Component/custom_buttom.dart';
import '../../../../Component/custom_text.dart';
import '../../../../Component/custom_textfield.dart';
import '../../../../Component/custom_toast.dart';
import '../../../../Utils/image_path.dart';
import '../../../../Utils/my_colors.dart';
import '../../Controller/auth_controller.dart';
import '../../Service/api_endpoints.dart';
import '../Widget/upload_media.dart';
import '../base_view.dart';

class DriverRegister extends StatelessWidget {
  Rx<File> imageProfile = File("").obs;
  RxBool carRegister = false.obs;

  @override
  Widget build(BuildContext context) {
    return BaseView(
      bgImage: ImagePath.bgImage,
      showBackgroundImage: true,
      resizeBottomInset: true,
      screenTitleColor: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.w),
        child: Obx(() {
          return GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 3.w),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          AppNavigation.navigatorPop(context);
                        },
                        child: Icon(
                          Icons.arrow_back_ios_rounded,
                          color: Colors.white,
                        ),
                      ),
                      MyText(title:'   Driver Registration',clr: MyColors().whiteColor,)
                    ],
                  ),
                ),
                SizedBox(
                  height: 4.w,
                ),
                Container(
                  margin: EdgeInsets.only(top: 6.h),
                  padding:EdgeInsets.symmetric(horizontal: 6.w,vertical: 6.w),
                  // height:i.value==2?58.h: 58.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // borderRadius: BorderRadius.circular(24),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    MyText(title: 'Add Your Picture',fontWeight: FontWeight.w600,size: 16,),
                    SizedBox(height: 2.h,),
                    Align(
                        alignment: Alignment.topLeft,
                        child: SizedBox(
                          child: CircleAvatar(
                            radius: 55.0,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 53.0,
                                backgroundImage:
                                (imageProfile.value.path == ""?
                                AuthController.i.user.value.userImage!=null?
                                NetworkImage(APIEndpoints.baseImageURL+AuthController.i.user.value.userImage??"") :
                                const AssetImage(ImagePath.noUserImage) :
                                FileImage(imageProfile.value)) as ImageProvider,
                                // imageProfile.value.path == "" ?const AssetImage(ImagePath.noUserImage,) : FileImage(imageProfile.value) as ImageProvider,
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 14.0,
                                    child: CircleAvatar(
                                      backgroundColor: MyColors().primaryColor,
                                    radius: 12.0,
                                      child: GestureDetector(
                                        onTap: () async {
                                          FocusManager.instance.primaryFocus?.unfocus();
                                          Get.bottomSheet(
                                            UploadMedia(
                                              file: (val) {
                                                imageProfile.value = val!;
                                              },
                                              singlePick: true,
                                            ),
                                            isScrollControlled: true,
                                            backgroundColor: Theme
                                                .of(context)
                                                .selectedRowColor,
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(20),
                                                    topRight: Radius.circular(20)
                                                )
                                            ),
                                          );
                                        },
                                        child: Image.asset(
                                          ImagePath.edit,
                                          color: MyColors().whiteColor,
                                          fit: BoxFit.fill,
                                          scale: 2,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                            ),
                          ),
                        )),
                    SizedBox(height: 3.h,),
                    MyText(
                      title: "Driver Name",
                      size: 13,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(height: 1.h,),
                    MyTextField(
                        width: 90.w,
                        hintText: 'Driver Name'.tr,
                        // controller: name,
                        onFieldSubmit: (val) {
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                      ),
                      SizedBox(height: 3.h,),
                      MyText(
                        title: "Emirates ID",
                        size: 13,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(height: 1.h,),
                      MyTextField(
                        width: 90.w,
                        hintText: 'Emirates ID'.tr,
                        // controller: name,
                        onFieldSubmit: (val) {
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                      ),

                      SizedBox(height: 3.h,),
                      MyText(
                        title: "Passport Number",
                        size: 13,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(height: 1.h,),
                      MyTextField(
                        width: 90.w,
                        hintText: 'Passport Number'.tr,
                        // controller: name,
                        onFieldSubmit: (val) {
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                      ),
                      SizedBox(height: 3.h,),
                      MyText(
                        title: "Do you want to register with your own car",
                        size: 13,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(height: 1.h,),
                      Row(children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: (){carRegister.value=false;},
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: carRegister.isFalse?MyColors().primaryColor: Colors.grey.withOpacity(0.1),
                                ),
                                borderRadius: BorderRadius.circular(12),
                                color: MyColors().whiteColor,
                              ),
                              padding: EdgeInsets.all(12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                MyText(title: 'No'),
                                Image.asset(carRegister.isFalse? ImagePath.radioF:ImagePath.radioE,scale: 2,)
                              ],),
                            ),
                          ),
                        ),
                        SizedBox(width: 3.w,),
                        Expanded(
                          child: GestureDetector(
                            onTap: (){carRegister.value=true;},
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: carRegister.isTrue?MyColors().primaryColor: Colors.grey.withOpacity(0.1),
                                ),
                                borderRadius: BorderRadius.circular(12),
                                color: MyColors().whiteColor,
                              ),
                              padding: EdgeInsets.all(12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  MyText(title: 'Yes'),
                                  Image.asset(carRegister.isTrue? ImagePath.radioF:ImagePath.radioE,scale: 2,)
                                ],),
                            ),
                          ),
                        ),
                      ],),
                      SizedBox(height: 3.h,),
                      MyButton(title: 'Next',onTap: (){
                        if(carRegister.isTrue){                        AppNavigation.navigateTo(context, AppRouteName.AddCar,arguments: ScreenArguments(fromSignup: true));}
                        else{
                          AppNavigation.navigateToRemovingAll(context, AppRouteName.HOME_SCREEN_ROUTE);
                        }
                      },),
                      SizedBox(height: 2.h,),
                    ],)
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
