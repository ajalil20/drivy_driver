import 'package:drivy_user/Component/Appbar/appbar_components.dart';
import 'package:drivy_user/Component/custom_background_image.dart';
import 'package:drivy_user/Component/custom_padding.dart';
import 'package:drivy_user/Component/custom_phone_textfield.dart';
import 'package:drivy_user/Component/custom_textfield.dart';
import 'package:drivy_user/Component/title.dart';
import 'package:drivy_user/Controller/auth_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:drivy_user/Service/navigation_service.dart';
import 'package:drivy_user/Utils/my_colors.dart';
import 'package:drivy_user/Utils/utils.dart';
import 'package:sizer/sizer.dart';
import '../../Component/custom_buttom.dart';
import '../../Component/custom_rectangle_textfield.dart';
import '../../Utils/image_path.dart';
import '../Widget/appLogo.dart';
import '../base_view.dart';

class EnterPhone extends StatelessWidget {
  EnterPhone({super.key});
  TextEditingController phone = TextEditingController();
  String dialCode = "+971";
  String countryCode = "AE";
  TextEditingController fullName = TextEditingController(),firstName = TextEditingController(),lastName = TextEditingController(),email = TextEditingController(),password = TextEditingController(), confirmPassword = TextEditingController(),dob = TextEditingController();
  // Rx<bool> isVisible = false.obs, isVisibleConfirm = false.obs, rememberMeLogin = false.obs;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: CustomBackgroundImage(
        image: ImagePath.signup,
        child: CustomPadding(
            topPadding: 0.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child:  SingleChildScrollView(
                    reverse: true,
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [

                        // MyTextField(
                        //   controller: firstName,
                        //   hintText: 'First Name',
                        //   maxLength: 30,
                        // ),
                        // SizedBox(height: 1.5.h,),
                        // MyTextField(
                        //   controller: lastName,
                        //   hintText: 'Last Name',
                        //   maxLength: 30,
                        // ),
                        // SizedBox(height: 1.5.h,),
                        // MyTextField(
                        //   controller: email,
                        //   hintText: 'Email',
                        //   inputType: TextInputType.emailAddress,
                        // ),
                        PhoneNumberTextField(
                          backgroundColor: MyColors().whiteColor,
                          controller: phone, onCountryChanged:(c){dialCode=c.dialCode;countryCode=c.code;},country: countryCode,
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        MyButton(
                            title: 'Continue to Verification',
                            onTap: () {
                              onSubmit(context);
                            }),

                        // SizedBox(height: 1.5.h,),
                        // MyTextField(
                        //     controller: password,
                        //     hintText: 'Password',
                        //     obscureText: isVisible.isTrue ? false : true,
                        //     suffixIconData: isVisible.isTrue ? const Icon(Icons.visibility_off,color: Colors.white,) : const Icon(Icons.visibility,color: Colors.white,),
                        //     onTapSuffixIcon: () {isVisible.value = !isVisible.value;}),
                        // SizedBox(height: 1.5.h,),
                        // MyTextField(
                        //     controller: confirmPassword,
                        //     maxLength: 30,
                        //     hintText: "Confirm Password",
                        //     obscureText: isVisibleConfirm.isTrue ? false : true,
                        //     suffixIconData: isVisibleConfirm.isTrue ? const Icon(Icons.visibility_off,color: Colors.white,) : const Icon(Icons.visibility,color: Colors.white,),
                        //     onTapSuffixIcon: () {isVisibleConfirm.value = !isVisibleConfirm.value;}),
                        // SizedBox(height: 1.5.h,),
                        // MyTextField(
                        //   controller: phone,
                        //   hintText: 'Phone',
                        //   inputType: TextInputType.phone,
                        //   contact: true,
                        // ),
                        // SizedBox(height: 1.5.h,),
                        // MyTextField(
                        //   controller: dob,
                        //   hintText: 'Date of birth',
                        //   readOnly: true,
                        //   onTap: ()async{
                        //     FocusManager.instance.primaryFocus?.unfocus();
                        //     dob.text=await Utils().selectDate(context);
                        //   },
                        // ),
                      ],
                    ),
                  ),
                ),


                SizedBox(
                  height: 2.h,
                  // height: 25.h,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 3.h),
                    child: RichText(
                      textAlign: TextAlign.center,
                      textScaleFactor: 1.03,
                      text: TextSpan(
                        text: "Already have an account? ",
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            color: MyColors().whiteColor
                        ),
                        children: [
                          TextSpan(
                            text: 'Login',
                            style: GoogleFonts.inter(
                                decoration:  TextDecoration.underline,
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                color: MyColors().linkColor
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                AppNavigation.navigatorPop(context);
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              ],
            )
        ),
      ),
    );
  }

  onSubmit(context) {
    AuthController.i.phone=phone.text;
    AuthController.i.dialCode=dialCode;
    AuthController.i.countryCode=countryCode;
    AuthController.i.phoneLoginValidation(context);
  }
}
