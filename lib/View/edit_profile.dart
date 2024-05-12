import 'dart:io';

import 'package:drivy_driver/Component/custom_dropdown.dart';
import 'package:drivy_driver/Model/category_product_model.dart';
import 'package:drivy_driver/Service/navigation_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/painting.dart';
import 'package:drivy_driver/Component/custom_buttom.dart';
import 'package:drivy_driver/Component/custom_textfield.dart';
import 'package:drivy_driver/Utils/my_colors.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import '../../../Component/custom_text.dart';
import '../Controller/auth_controller.dart';
import '../Utils/image_path.dart';
import 'Widget/upload_media.dart';
import 'base_view.dart';

class EditProfile extends StatefulWidget {
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController firstName = TextEditingController(),lastName = TextEditingController(), email= TextEditingController(), phone= TextEditingController(), country= TextEditingController();
  Rx<File> imageProfile = File("").obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstName.text=AuthController.i.user.value.firstName;
    lastName.text=AuthController.i.user.value.lastName;
    email.text=AuthController.i.user.value.email;
    phone.text=AuthController.i.user.value.phoneNumber.toString();
    country.text=AuthController.i.user.value.country;
  }

  @override
  Widget build(BuildContext context) {
    // responsive.setContext(context);
    return BaseView(
      showAppBar: true,
      showBackButton: true,
      screenTitle: "Edit Profile",
      centerTitle: false,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child:  Padding(
          padding: EdgeInsets.only(top: 4.h, left: 4.w, right: 4.w),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(ImagePath.imgCircle)
                    )
                ),
                child: Align(
                    alignment: Alignment.topCenter,
                    child: Obx(()=> CircleAvatar(
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
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: CircleAvatar(
                              backgroundColor: MyColors().primaryColor,
                              radius: 14.0,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
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
                                    child: Icon(Icons.camera_alt_rounded,color: MyColors().primaryColor,size: 14,)
                                ),
                              ),
                            ),
                          )
                      ),
                    ),
                    )),
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 2.w, bottom: 1.h),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: MyText(title: "First Name",
                      size: 13,
                      fontWeight: FontWeight.w600,)),
              ),
              MyTextField(
                width: 90.w,
                hintText: 'First Name'.tr,
                controller: firstName,
                onFieldSubmit: (val) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 2.w, bottom: 1.h),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: MyText(title: "Last Name",
                      size: 13,
                      fontWeight: FontWeight.w600,)),
              ),
              MyTextField(
                width: 90.w,
                hintText: 'Last Name'.tr,
                controller: lastName,
                onFieldSubmit: (val) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 2.w, bottom: 1.h),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: MyText(title: "Email Address",
                      size: 13,
                      fontWeight: FontWeight.w600,)),
              ),
              MyTextField(
                width: 90.w,
                readOnly: true,
                hintText: 'Email Address'.tr,
                controller: email,
                inputType: TextInputType.emailAddress,
                onFieldSubmit: (val) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 2.w, bottom: 1.h),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: MyText(title: "Country",
                      size: 13,
                      fontWeight: FontWeight.w600,)),
              ),
              MyTextField(
                width: 90.w,
                hintText: 'Country'.tr,
                maxLength: 8,
                controller: country,
                // inputType: TextInputType.emailAddress,
                onFieldSubmit: (val) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 2.w, bottom: 1.h),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: MyText(title: "Phone Number",
                      size: 13,
                      fontWeight: FontWeight.w600,)),
              ),
              MyTextField(
                width: 90.w,
                hintText: 'Phone Number'.tr,
                inputType: TextInputType.phone,
                readOnly: true,
                controller: phone,
                onFieldSubmit: (val) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
              ),
              SizedBox(
                height: 3.h,
              ),
              MyButton(title: "Update Profile",onTap: (){
                onSubmit();
              },)

            ],
          ),
        ),
      ),
    );
  }

  onSubmit()async{
    AuthController.i.imageProfile = imageProfile.value.path;
    AuthController.i.firstName=firstName.text;
    AuthController.i.lastName=lastName.text;
    AuthController.i.email=email.text;
    AuthController.i.country=country.text;
    AuthController.i.phone=phone.text;
    AuthController.i.editProfile(context,onSuccess: (){AppNavigation.navigatorPop(context);},editProfile: true);
  }
}