import 'package:drivy_driver/Component/Appbar/appbar_components.dart';
import 'package:drivy_driver/Component/custom_background_image.dart';
import 'package:drivy_driver/Component/custom_padding.dart';
import 'package:drivy_driver/Component/custom_phone_textfield.dart';
import 'package:drivy_driver/Controller/auth_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:drivy_driver/Service/navigation_service.dart';
import 'package:drivy_driver/View/Authentication/forgot_password.dart';
import 'package:drivy_driver/View/Authentication/signup_screen.dart';
import 'package:sizer/sizer.dart';
import 'package:drivy_driver/View/Widget/appLogo.dart';
import '../../Component/custom_buttom.dart';
import '../../Component/custom_rectangle_textfield.dart';
import '../../Component/custom_text.dart';
import '../../Component/title.dart';
import '../../Utils/app_router_name.dart';
import '../../Utils/image_path.dart';
import '../../Utils/my_colors.dart';
import '../base_view.dart';

class PhoneLogin extends StatelessWidget {
  PhoneLogin({super.key});
  AuthController controller = Get.put(AuthController());
  TextEditingController phone = TextEditingController();
  String dialCode = "+971";
  String countryCode = "AE";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: CustomBackgroundImage(
        child: CustomPadding(
          topPadding: 6.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(alignment: Alignment.centerLeft, child: CustomBackButton(color: MyColors().whiteColor,)),
              SizedBox(height: 3.h,), 
              AppLogo(
                onTap: (){
                  phone.text="1234567890";
                },
              ),

              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 8.h,
                      ),
                      ScreenTitle(title: 'Login'),
                      SizedBox(
                        height: 2.h,
                      ),
                      PhoneNumberTextField(
                          controller: phone, onCountryChanged:(c){dialCode=c.dialCode;countryCode=c.code;}
                      ),
                      // SizedBox(
                      //   height: 2.h,
                      // ),
                      //
                      // Align(
                      //   alignment: Alignment.centerRight,
                      //   child:  GestureDetector(
                      //     onTap: () {
                      //       FocusManager.instance.primaryFocus?.unfocus();
                      //       AppNavigation.navigateTo(context, AppRouteName.FORGET_PASSWORD_ROUTE,);
                      //     },
                      //     child: const MyText(
                      //       title: "Forgot Password?",
                      //       size: 15,
                      //       under: true,
                      //       weight: "Semi Bold",
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        height: 4.h,
                      ),
                      MyButton(
                          title: "Next",
                          onTap: () { onSubmit(context);}),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  onSubmit(context){
    AuthController.i.dialCode=dialCode;
    AuthController.i.countryCode=countryCode;
    AuthController.i.phone =phone.text;
    AuthController.i.phoneLoginValidation(context);
  }
}
