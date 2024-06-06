import 'package:drivy_driver/Component/Appbar/appbar_components.dart';
import 'package:drivy_driver/Component/custom_background_image.dart';
import 'package:drivy_driver/Component/custom_padding.dart';
import 'package:drivy_driver/Component/custom_phone_textfield.dart';
import 'package:drivy_driver/Component/custom_textfield.dart';
import 'package:drivy_driver/Component/title.dart';
import 'package:drivy_driver/Controller/auth_controller.dart';
import 'package:drivy_driver/Utils/app_router_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:drivy_driver/Service/navigation_service.dart';
import 'package:drivy_driver/Utils/my_colors.dart';
import 'package:drivy_driver/Utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import '../../Component/custom_buttom.dart';
import '../../Component/custom_rectangle_textfield.dart';
import '../../Component/custom_text.dart';
import '../../Utils/image_path.dart';
import '../Widget/appLogo.dart';
import '../base_view.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  // TextEditingController phone = TextEditingController();
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
        child: CustomPadding(
            topPadding: 2.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ScreenTitle(title: 'Sign up'),
                SizedBox(
                  height: 1.h,
                ),
                const MyText(title: 'Enter your details to register on Drivy and enjoy the freedom.',fontWeight: FontWeight.w600  ,),
                SizedBox(
                  height: 2.h,
                ),
                Expanded(
                  child:  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyTextField(
                          controller: firstName,
                          hintText: 'First Name',
                          maxLength: 30,
                        ),
                        SizedBox(height: 1.5.h,),
                        MyTextField(
                          controller: lastName,
                          hintText: 'Last Name',
                          maxLength: 30,
                        ),
                        SizedBox(height: 1.h,),
                        const MyText(title: 'Make sure it matches the name on your government ID.',size: 11,),
                        SizedBox(height: 3.h,),
                        MyTextField(
                          controller: dob,
                          hintText: 'Birthday (dd/mm/yyyy)',
                          maxLength: 30,
                          readOnly: true,
                          suffixIconData: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            size: 25,
                            color: Colors.black,
                          ),
                          onTap: () async {
                            await showCupertinoModalPopup<void>(
                              context: context,
                              builder: (_) {
                                final size = MediaQuery.of(context).size;
                                return Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12),
                                    ),
                                  ),
                                  height: size.height * 0.27,
                                  child: CupertinoDatePicker(
                                    mode: CupertinoDatePickerMode.date,
                                    initialDateTime:   DateTime(DateTime.now().year - 17),
                                    minimumDate: DateTime(DateTime.now().year - 100),
                                    maximumDate: DateTime.now(),
                                    onDateTimeChanged: (value) {
                                      dob.text= DateFormat('yyyy-MM-dd').format(value).toString();
                                      // dob.text= DateFormat('dd/MM/yyyy').format(value).toString();
                                    },
                                  ),
                                );
                              },
                            );
                          },
                          // suffixIcons: Icon(Icons.keyboard_arrow_down_rounded,size: 20,color: Colors.black,),
                        ),
                        SizedBox(height: 1.h,),
                        const MyText(title: 'To sign up, you need to be at least 18. Your birthday won’t be shared with other people who use Drivy.',size: 11,),
                        SizedBox(height: 3.h,),
                        MyTextField(
                          controller: email,
                          hintText: 'Email',
                          inputType: TextInputType.emailAddress,
                          maxLength: 35,
                        ),
                        SizedBox(height: 1.h,),
                        const MyText(title: 'We’ll email your booking confirmations and receipts.',size: 11,),
                        SizedBox(
                          height: 3.h,
                        ),
                        RichText(
                          textAlign: TextAlign.center,
                          textScaleFactor: 1.03,
                          text: TextSpan(
                            text: "By selecting Continue, I agree to Drivy ",
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                                color: MyColors().black
                            ),
                            children: [
                              TextSpan(
                                text: 'Terms of Service',
                                style: GoogleFonts.inter(
                                    decoration:  TextDecoration.underline,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                    color: MyColors().linkColor
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // FocusManager.instance.primaryFocus?.unfocus();
                                    // AppNavigation.navigatorPop(context);
                                  },
                              ),
                              TextSpan(
                                text: ' , ',
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                    color: MyColors().black
                                ),
                              ),
                              TextSpan(
                                text: 'Terms of Payments',
                                style: GoogleFonts.inter(
                                    decoration:  TextDecoration.underline,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                    color: MyColors().linkColor
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // FocusManager.instance.primaryFocus?.unfocus();
                                    // AppNavigation.navigatorPop(context);
                                  },
                              ),
                              TextSpan(
                                text: ' and acknowledge the ',
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                    color: MyColors().black
                                ),
                              ),
                              TextSpan(
                                text: 'Privacy Policy',
                                style: GoogleFonts.inter(
                                    decoration:  TextDecoration.underline,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                    color: MyColors().linkColor
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // FocusManager.instance.primaryFocus?.unfocus();
                                    // AppNavigation.navigatorPop(context);
                                  },
                              ),
                              TextSpan(
                                text: ' .',
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                    color: MyColors().black
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),

                      ],
                    ),
                  ),
                ),

                MyButton(
                    title: 'Continue',
                    onTap: () {
                      onSubmit(context);
                    }),
                SizedBox(
                  height: 2.h,
                  // height: 25.h,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 0.h),
                    child: RichText(
                      textAlign: TextAlign.center,
                      textScaleFactor: 1.03,
                      text: TextSpan(
                        text: "Already have an account? ",
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            color: MyColors().black
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
                SizedBox(height: 2.h),
              ],
            )
        ),
      ),
    );
  }

  onSubmit(context) {
    // AuthController.i.phone=phone.text;
    AuthController.i.dialCode=dialCode;
    AuthController.i.countryCode=countryCode;
    AuthController.i.dob=dob.text;

    AuthController.i.firstName = firstName.text;
    AuthController.i.lastName = lastName.text;
    AuthController.i.email = email.text;
    AuthController.i.signUpValidation(context);
  }
}
