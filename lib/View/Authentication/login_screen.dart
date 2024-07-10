 import 'package:drivy_driver/Component/Appbar/appbar_components.dart';
import 'package:drivy_driver/Component/custom_background_image.dart';
import 'package:drivy_driver/Component/custom_checkbox.dart';
import 'package:drivy_driver/Component/custom_padding.dart';
import 'package:drivy_driver/Component/custom_textfield.dart';
import 'package:drivy_driver/Component/custom_title_text.dart';
import 'package:drivy_driver/Controller/auth_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:drivy_driver/Service/navigation_service.dart';
import 'package:drivy_driver/Utils/my_colors.dart';
import 'package:drivy_driver/View/Authentication/forgot_password.dart';
import 'package:drivy_driver/View/Authentication/signup_screen.dart';
import 'package:sizer/sizer.dart';
import 'package:drivy_driver/View/Widget/appLogo.dart';
import '../../Component/custom_buttom.dart';
import '../../Component/custom_phone_textfield.dart';
import '../../Component/custom_rectangle_textfield.dart';
import '../../Component/custom_text.dart';
import '../../Component/title.dart';
import '../../Utils/app_router_name.dart';
import '../../Utils/image_path.dart';
import '../base_view.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  // LoginController controller = Get.put(LoginController());
  // Get.put(AuthController());
  RxBool isVisible = false.obs;
  RxBool rememberMeLogin = false.obs;
  RxBool isEmail = true.obs;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
  String dialCode = "+971";
  String countryCode = "AE";
  AuthController controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: CustomBackgroundImage(
        child:Obx(()=> CustomPadding(
            topPadding: 2.h,
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ScreenTitle(title: 'Login'),
                SizedBox(
                  height: 1.h,
                ),
                const MyText(title: 'Enter your details to login or continue with another method.'),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 4.h,
                        ),
                        isEmail.isTrue?
                        MyTextField(
                          hintText: 'Email',
                          maxLength: 30,
                          controller: email,
                          inputType: TextInputType.emailAddress,
                        ):PhoneNumberTextField(
                            controller: phone, onCountryChanged:(c){dialCode=c.dialCode;countryCode=c.code;},country: countryCode,
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        MyTextField(
                            controller: password,
                            maxLength: 30,
                            hintText: "New Password",
                            obscureText: isVisible.isTrue? false : true,
                            suffixIconData: isVisible.isTrue? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
                            onTapSuffixIcon: () {isVisible.value = !isVisible.value;}
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Row(
                          children: [
                            CheckBoxWidget(
                              defaultVal: rememberMeLogin.value,
                              onChange: (v) {
                                rememberMeLogin.value=v;
                              },),
                            const Expanded(
                              child: MyText(
                                title: ' Remember Me',
                                size: 12,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                AppNavigation.navigateTo(context, AppRouteName.FORGET_PASSWORD_ROUTE,);
                                },
                              child: MyText(
                                title: "Forgot Password?",
                                size: 12,
                                clr: MyColors().linkColor,
                                under: true,
                                weight: "Semi Bold",
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        MyButton(
                            title: "Login",
                            onTap: () { onSubmit(context);}),
                        SizedBox(
                          height: 2.h,
                        ),
                        RichText(
                          textAlign: TextAlign.center,
                          textScaleFactor: 1.03,
                          text: TextSpan(
                            text: "Don't have an account? ",
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                              color: MyColors().black
                            ),
                            children: [
                              TextSpan(
                                text: 'Sign up now',
                                style: GoogleFonts.inter(
                                    decoration:  TextDecoration.underline,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                    color: MyColors().linkColor
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    FocusManager.instance.primaryFocus?.unfocus();
                                    AppNavigation.navigateTo(context, AppRouteName.ENTER_PHONE_SCREEN_ROUTE,);
                                  },
                              ),
                            ],
                          ),
                        ),
                      SizedBox(
                          height: 2.h,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  onSubmit(context){
    AuthController.i.email=email.text;
    AuthController.i.phone=phone.text;
    AuthController.i.dialCode=dialCode;
    AuthController.i.countryCode=countryCode;
    AuthController.i.password=password.text;
    AuthController.i.loginValidation(context,isEmail: isEmail.value);
  }
}
