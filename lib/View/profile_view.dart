
import 'dart:io';

import 'package:drivy_driver/Controller/auth_controller.dart';
import 'package:drivy_driver/Model/menu_model.dart';
import 'package:drivy_driver/Service/navigation_service.dart';
import 'package:drivy_driver/Utils/app_router_name.dart';
import 'package:drivy_driver/View/Products/add_product.dart';
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
import 'Widget/upload_media.dart';
import 'base_view.dart';

class ProfileView extends StatelessWidget {
  Rx<File> imageProfile = File("").obs;

  @override
  Widget build(BuildContext context) {
    return BaseView(
      bgImage: ImagePath.bgImage,
      showBackgroundImage: true,
      resizeBottomInset: true,
      screenTitleColor: Colors.white,
      bottomSafeArea: false,
      child: Obx(() {
        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      AppNavigation.navigatorPop(context);
                    },
                    child: Image.asset(ImagePath.back,scale: 2,)
                  ),
                  Expanded(
                    child: MyText(title: "    Profile",
                      size: 16,
                      weight: "Semi Bold",
                      clr: Colors.white,),
                  ),
                  GestureDetector(
                      onTap: () {
                        AppNavigation.navigateTo(context, AppRouteName.editProfile);
                      },
                      child: Image.asset(ImagePath.edit2,scale: 2,)
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(ImagePath.imgCircle)
                  )
                ),
                child: Align(
                    alignment: Alignment.topCenter,
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
                            NetworkImage(AuthController.i.user.value.userImage??"") :
                            const AssetImage(ImagePath.noUserImage) :
                            FileImage(imageProfile.value)) as ImageProvider,
                            // imageProfile.value.path == "" ?const AssetImage(ImagePath.noUserImage,) : FileImage(imageProfile.value) as ImageProvider,
                            // child: Align(
                            //   alignment: Alignment.bottomRight,
                            //   child: CircleAvatar(
                            //     backgroundColor: MyColors().primaryColor,
                            //     radius: 14.0,
                            //     child: CircleAvatar(
                            //       backgroundColor: Colors.white,
                            //       radius: 12.0,
                            //       child: GestureDetector(
                            //           onTap: () async {
                            //             FocusManager.instance.primaryFocus?.unfocus();
                            //             Get.bottomSheet(
                            //               UploadMedia(
                            //                 file: (val) {
                            //                   imageProfile.value = val!;
                            //                 },
                            //                 singlePick: true,
                            //               ),
                            //               isScrollControlled: true,
                            //               backgroundColor: Theme
                            //                   .of(context)
                            //                   .selectedRowColor,
                            //               shape: const RoundedRectangleBorder(
                            //                   borderRadius: BorderRadius.only(
                            //                       topLeft: Radius.circular(20),
                            //                       topRight: Radius.circular(20)
                            //                   )
                            //               ),
                            //             );
                            //           },
                            //           child: Icon(Icons.camera_alt_rounded,color: MyColors().primaryColor,size: 14,)
                            //       ),
                            //     ),
                            //   ),
                            // )
                        ),
                      ),
                    )),
              ),
              SizedBox(height: 2.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyText(title:'${AuthController.i.user.value.fullName}  ',size: 14,clr: MyColors().whiteColor,fontWeight: FontWeight.w600,),
                 Image.asset(ImagePath.star,scale: 3,color: MyColors().primaryColor,),
                  MyText(title:'  4.5',size: 14,clr: MyColors().whiteColor,fontWeight: FontWeight.w600,),
                ],
              ),

              // MyText(title:AuthController.i.user.value.email,size: 12,clr: MyColors().whiteColor),

              // Obx(()=> ),

              SizedBox(height: 3.h),
              Spacer(),
              Container(
                width: 100.w,
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(color: MyColors().whiteColor),child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                MyText(title:'Personal info',size: 16,fontWeight: FontWeight.w600,),
                  SizedBox(height: 3.h),
                  customImageText(img:ImagePath.user,text: AuthController.i.user.value.fullName),
                  SizedBox(height: 2.h),
                  customImageText(img:ImagePath.email2,text: AuthController.i.user.value.email),
                  SizedBox(height: 2.h),
                  customImageText(img:ImagePath.flag,text: AuthController.i.user.value.countryCode),
                  SizedBox(height: 2.h),
                  customImageText(img:ImagePath.phone2,text: '${AuthController.i.user.value.phoneNumber}'),
                  SizedBox(height: 1.h),
                  GestureDetector(
                      onTap: (){
                        AppNavigation.navigateTo(context, AppRouteName.AddCar);
                      },
                      child: Image.asset(ImagePath.addCar,scale: 2,)),
                  SizedBox(height: 2.h),

                ],),),
              // Spacer(),

            ],
          ),
        );
      }),
    );
  }

  customImageText({required String img,required String text}){
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xffDAE1F1),
        ),
        borderRadius: BorderRadius.circular(10),
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

      // padding: EdgeInsets.all(12),
      padding: EdgeInsets.symmetric(vertical: 1.h,horizontal: 2.w),
      child:  Row(
        children: [
          Image.asset(img,scale: 2,),
          SizedBox(width : 2.w),
          Expanded(child: MyText(title: text,fontWeight: FontWeight.w600,clr: Color(0xff455267),line: 1,)),
        ],
      ),
    );
  }
}
