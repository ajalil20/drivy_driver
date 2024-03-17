import 'dart:async';
import 'package:drivy_driver/Component/Appbar/appbar_components.dart';
import 'package:drivy_driver/Component/custom_background_image.dart';
import 'package:drivy_driver/Component/custom_padding.dart';
import 'package:drivy_driver/Component/custom_textfield.dart';
import 'package:drivy_driver/Component/title.dart';
import 'package:drivy_driver/Controller/auth_controller.dart';
import 'package:drivy_driver/Service/navigation_service.dart';
import 'package:drivy_driver/Utils/app_router_name.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:drivy_driver/Controller/global_controller.dart';
import 'package:drivy_driver/Controller/home_controller.dart';
import 'package:drivy_driver/Utils/enum.dart';
import 'package:drivy_driver/View/Widget/appLogo.dart';
import '../../../Component/custom_buttom.dart';
import '../../../Component/custom_text.dart';
import '../../../Utils/my_colors.dart';
import '../../Component/custom_toast.dart';
import '../../Utils/image_path.dart';
import '../base_view.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/services.dart';
// import 'package:timer_builder/timer_builder.dart';

class CreatePassword extends StatelessWidget {
  CreatePassword({this.fromForgetPassword});
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  Rx<bool> isVisible = false.obs;
  Rx<bool> isVisibleConfirm = false.obs;
  bool? fromForgetPassword;
  @override
  Widget build(BuildContext context) {
    return  CustomBackgroundImage(
      child: CustomPadding(
        topPadding: 0.h,
        child: Obx(()=> Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(alignment: Alignment.centerLeft, child: CustomBackButton(color: MyColors().whiteColor,)),
              SizedBox(height: 3.h,),
              ScreenTitle(title: 'Create Password'),
              SizedBox(
                height: 1.h,
              ),
              const MyText(title: 'Create a strong and unique password to keep your account secure.',fontWeight: FontWeight.w600  ,),
              SizedBox(
                height: 3.h,
              ),
              MyTextField(
                title: "Password",
                controller: password,
                hintText: "Password",
                maxLength: 30,
                obscureText: isVisible.value == true ? false : true,
                suffixIconData:isVisible.value == true ? Container(width: 5.w, child: Image.asset(ImagePath.closeEye,scale: 2,)) : Container(width: 5.w, child: Image.asset(ImagePath.eye,scale: 2,)) ,
                onTapSuffixIcon: () {isVisible.value = !isVisible.value;},
              ),
              SizedBox(height: 1.h,),
              MyTextField(
                title: "Confirm Password",
                controller: confirmPassword,
                hintText: "Confirm Password",
                maxLength: 30,
                obscureText: isVisibleConfirm.value == true ? false : true,
                suffixIconData:isVisibleConfirm.value == true ? Container(width: 5.w, child: Image.asset(ImagePath.closeEye,scale: 2,)) : Container(width: 5.w, child: Image.asset(ImagePath.eye,scale: 2,)) ,
                onTapSuffixIcon: () {isVisibleConfirm.value = !isVisibleConfirm.value;},
              ),
              SizedBox(height: 3.h,),
              const MyText(title: 'To create a strong password, follow these tips:',fontWeight: FontWeight.w600  ,),
              SizedBox(height: 1.h,),
              pointText(p: '1.', t: 'Length: The longer the password, the more difficult it is to crack. Aim for a minimum of 8 characters, but preferably 12 or more. '),
              pointText(p: '2.', t: 'Complexity: A strong password should include a combination of uppercase and lowercase letters, numbers, and symbols. '),
              pointText(p: '3.', t: 'Uniqueness: Do not use the same password for multiple accounts. If one account is compromised, all other accounts with the same password are also at risk.'),
              const Spacer(),
              MyButton(title: fromForgetPassword==true?'Continue' :'Complete Sign up',onTap: (){onSubmit(context);},),
              SizedBox(height: 1.h),
              if(fromForgetPassword!=true)
              Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  textScaleFactor: 1.03,
                  text: TextSpan(
                    text: "Need to edit something? ",
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        color: MyColors().black
                    ),
                    children: [
                      TextSpan(
                        text: 'Back to Sign-up',
                        style: GoogleFonts.inter(
                            decoration:  TextDecoration.underline,
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                            color: MyColors().linkColor
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                           AppNavigation.navigatorPop(context);
                          },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 0.h),
            ],
          ),
        ),
      ),
    );
  }

  onSubmit(context){
    AppNavigation.navigateTo(context, AppRouteName.DriverRegister);
    // AppNavigation.navigateToRemovingAll(context, AppRouteName.HOME_SCREEN_ROUTE);
    // AuthController.i.otp=otp.text;
    // AuthController.i.otpValidation(context,firebase:widget.isFirebase??false);
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

}
