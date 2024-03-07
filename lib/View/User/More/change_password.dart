import 'dart:developer';

import 'package:drivy_driver/Component/custom_padding.dart';
import 'package:flutter/material.dart';
import 'package:drivy_driver/Component/custom_buttom.dart';
import '../../../../../../Utils/my_colors.dart';
import '../../../../../Component/custom_text.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../Component/custom_textfield.dart';
import '../../../Component/custom_title_text.dart';
import '../../../Controller/auth_controller.dart';
import '../../../Utils/image_path.dart';
import '../../base_view.dart';
import '../../edit_profile.dart';

class ChangePassword extends StatelessWidget {
  ChangePassword({super.key});
  TextEditingController currentPassword = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  RxBool isCurrentVisible = false.obs;
  RxBool isVisible = false.obs;
  RxBool isVisibleConfirm = false.obs;

  @override
  Widget build(BuildContext context) {
    return BaseView(
      screenTitle: "",
      showAppBar: true,
      showBackButton: true,
      resizeBottomInset: false,
      child: Obx(() {
        return CustomPadding(
          topPadding: 2.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(title: 'Change Password',size: 16,fontWeight: FontWeight.w600,),
              SizedBox(height: 1.h),
              MyText(title: 'Create a strong and unique password to keep your account secure.',size: 13,fontWeight: FontWeight.w600,),
              SizedBox(height: 3.h),
              MyTextField(
                controller: currentPassword,
                hintText: "Old Password",
                maxLength: 30,
                obscureText: isCurrentVisible.isTrue? false : true,
                suffixIconData:isCurrentVisible.value == true ? Container(width: 5.w, child: Image.asset(ImagePath.closeEye,scale: 2,)) : Container(width: 5.w, child: Image.asset(ImagePath.eye,scale: 2,)) ,
                onTapSuffixIcon: () {isCurrentVisible.value = !isCurrentVisible.value;},
              ),
              SizedBox(
                height: 2.h,
              ),
              MyTextField(
                  controller: password,
                  maxLength: 30,
                  hintText: "New Password",
                  obscureText: isVisible.isTrue? false : true,
                  suffixIconData:isVisible.value == true ? Container(width: 5.w, child: Image.asset(ImagePath.closeEye,scale: 2,)) : Container(width: 5.w, child: Image.asset(ImagePath.eye,scale: 2,)) ,
                  onTapSuffixIcon: () {isVisible.value = !isVisible.value;}
              ),
              SizedBox(
                height: 2.h,
              ),
              MyTextField(
                  controller: confirmPassword,
                  maxLength: 30,
                  hintText: "Re-enter Password",
                  obscureText: isVisibleConfirm.isTrue? false : true,
                  suffixIconData:isVisibleConfirm.value == true ? Container(width: 5.w, child: Image.asset(ImagePath.closeEye,scale: 2,)) : Container(width: 5.w, child: Image.asset(ImagePath.eye,scale: 2,)) ,
                  onTapSuffixIcon: () {isVisibleConfirm.value = !isVisibleConfirm.value;}
              ),
              SizedBox(height: 3.h,),
              const MyText(title: 'To create a strong password, follow these tips:',fontWeight: FontWeight.w600  ,),
              SizedBox(height: 1.h,),
              pointText(p: '1.', t: 'Length: The longer the password, the more difficult it is to crack. Aim for a minimum of 8 characters, but preferably 12 or more. '),
              pointText(p: '2.', t: 'Complexity: A strong password should include a combination of uppercase and lowercase letters, numbers, and symbols. '),
              pointText(p: '3.', t: 'Uniqueness: Do not use the same password for multiple accounts. If one account is compromised, all other accounts with the same password are also at risk.'),
              const Spacer(),
              Center(
                child: MyButton(
                    width: 90.w,
                    title: "Save",
                    onTap: () {
                      onSubmit(context);
                    }),
              ),
              SizedBox(height: 5.h),

            ],
          ),
        );
      }),
    );
  }
  pointText({p ,t}){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText(title: '$p   ',fontWeight: FontWeight.w600  ,),
        Expanded(child: MyText(title: t,fontWeight: FontWeight.w600  ,)),
      ],
    );
  }
  onSubmit(context){
    // AuthController.i.currentPassword=currentPassword.text;
    AuthController.i.password=password.text;
    // AuthController.i.confirmPassword=confirmPassword.text;
    // AuthController.i.changePasswordValidation(context);
  }
}
