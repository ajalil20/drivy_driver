import 'package:drivy_driver/Arguments/screen_arguments.dart';
import 'package:drivy_driver/Component/custom_padding.dart';
import 'package:drivy_driver/Controller/auth_controller.dart';
import 'package:drivy_driver/Service/navigation_service.dart';
import 'package:drivy_driver/Utils/app_router_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../Component/custom_buttom.dart';
import '../../../Utils/image_path.dart';
import '../../Component/Appbar/appbar_components.dart';
import '../../Component/custom_background_image.dart';
import '../../Component/custom_rectangle_textfield.dart';
import '../../Component/custom_text.dart';
import '../../Component/custom_textfield.dart';
import '../../Component/title.dart';
import '../../Utils/my_colors.dart';
import '../Widget/appLogo.dart';
import '../base_view.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});

  TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomBackgroundImage(
      child: CustomPadding(
        topPadding: 0.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(alignment: Alignment.centerLeft, child: CustomBackButton(color: MyColors().whiteColor,)),
            SizedBox(height: 3.h,),
            ScreenTitle(title: 'Forgot Password'),
            SizedBox(
              height: 1.h,
            ),
            const MyText(title: 'Create a strong and unique password to keep your account secure.',fontWeight: FontWeight.w600  ,),
            SizedBox(
              height: 3.h,
            ),
            MyTextField(
              hintText: 'Email',
              maxLength: 30,
              controller: email,
              inputType: TextInputType.emailAddress,
            ),
            // CustomRectangulatTextFormField(
            //     controller: email,
            //     hintText: 'EMAIL',
            //     maxLength: 35,
            //     iconPath: ImagePath.emailIcon,
            //     isIcon: false,
            //     title: 'EMAIL',
            //     keyType: TextInputType.emailAddress,
            //   ),
            SizedBox(height: 3.h,),
            const MyText(title: 'To create a strong password, follow these tips:',fontWeight: FontWeight.w600  ,),
            SizedBox(height: 1.h,),
            pointText(p: '1.', t: 'Length: The longer the password, the more difficult it is to crack. Aim for a minimum of 8 characters, but preferably 12 or more. '),
            pointText(p: '2.', t: 'Complexity: A strong password should include a combination of uppercase and lowercase letters, numbers, and symbols. '),
            pointText(p: '3.', t: 'Uniqueness: Do not use the same password for multiple accounts. If one account is compromised, all other accounts with the same password are also at risk.'),
            const Spacer(),
            MyButton(title: 'Continue', onTap: (){onSubmit(context);}),
              // SizedBox(height:2.h),
            ],
          ),
        ),
    );
  }
  onSubmit(context){
    AuthController.i.email=email.text;
    AppNavigation.navigateTo(context, AppRouteName.ENTER_OTP_SCREEN_ROUTE,arguments: ScreenArguments(fromForgetPassword:true));
    // AuthController.i.forgetPasswordValidation(context);
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

