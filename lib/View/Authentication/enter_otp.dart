import 'dart:async';
import 'package:drivy_driver/Component/Appbar/appbar_components.dart';
import 'package:drivy_driver/Component/custom_background_image.dart';
import 'package:drivy_driver/Component/custom_padding.dart';
import 'package:drivy_driver/Component/title.dart';
import 'package:drivy_driver/Controller/auth_controller.dart';
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

class EnterOTP extends StatefulWidget {
  @override
  State<EnterOTP> createState() => _EnterOTPState();
  EnterOTP({super.key, required this.isFirebase,this.fromForgetPassword});
  bool? isFirebase;
  bool? fromForgetPassword;
}

class _EnterOTPState extends State<EnterOTP> {
  TextEditingController otp = TextEditingController(text: "");
  /// #Timer
  Timer? _countdownTimer;
  Duration _duration = const Duration(seconds: 59);
  bool isTimeComplete = false;

  @override
  void initState() {
    /// #Timer
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  CustomBackgroundImage(
      child: CustomPadding(
        topPadding: 0.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(alignment: Alignment.centerLeft, child: CustomBackButton(color: MyColors().whiteColor,)),
            SizedBox(height: 3.h,),
            ScreenTitle(title: 'Enter OTP'),
            SizedBox(
              height: 2.h,
            ),
            // MyText(title: 'We have sent you a verification code via to ${phone?'SMS':'an email' } to ${phone?AuthController.i.dialCode+AuthController.i.phone : AuthController.i.email}',clr: MyColors().whiteColor,center: true,size: 15,),
            RichText(
              // textAlign: TextAlign.center,
              textScaleFactor: 1.03,
              text: TextSpan(
                text: 'We have sent you a verification code via SMS to ',
                style: GoogleFonts.inter(
                  color: MyColors().black,
                  fontSize: 16
                ),
                children: [
                  TextSpan(
                    text: '${AuthController.i.dialCode} ${AuthController.i.phone}',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                        fontSize: 16
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: PinCodeTextField(
                appContext: context,
                length: 4,
                controller: otp,
                onCompleted: (v){setState(() {});},
                autoDismissKeyboard: true,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  fieldWidth: 15.w,
                  fieldHeight: 15.w,
                  activeFillColor: Colors.transparent,
                  inactiveFillColor: Colors.transparent,
                  selectedFillColor: Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  inactiveColor: MyColors().borderColor,
                  activeColor: MyColors().borderColor,
                  selectedColor: MyColors().black,
                  borderWidth: 1,
                  errorBorderColor: Theme.of(context).colorScheme.error,
                ),
                onChanged: (v){if(otp.text.length==3){setState(() {});}},
                textStyle: TextStyle(color: MyColors().black, fontSize: 15),
                cursorColor: MyColors().whiteColor,
                keyboardType: const TextInputType.numberWithOptions(decimal: false, signed: false),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                enableActiveFill: true,
              ),
            ),
            ///6 Digits
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 5.w),
            //   child: PinCodeTextField(
            //     appContext: context,
            //     length: 6,
            //     controller: otp,
            //     onCompleted: (v){onSubmit(context);},
            //     autoDismissKeyboard: true,
            //     pinTheme: PinTheme(
            //       shape: PinCodeFieldShape.box,
            //       fieldWidth: 12.w,
            //       fieldHeight: 12.w,
            //       activeFillColor: Colors.transparent,
            //       inactiveFillColor: Colors.transparent,
            //       selectedFillColor: Colors.transparent,
            //       borderRadius: BorderRadius.circular(8),
            //       inactiveColor: MyColors().whiteColor,
            //       activeColor: MyColors().whiteColor,
            //       selectedColor: MyColors().whiteColor,
            //       borderWidth: 1,
            //       errorBorderColor: Theme.of(context).colorScheme.error,
            //     ),
            //     textStyle: TextStyle(color: MyColors().whiteColor, fontSize: 15),
            //     cursorColor: MyColors().whiteColor,
            //     keyboardType: const TextInputType.numberWithOptions(decimal: false, signed: false),
            //     inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            //     enableActiveFill: true,
            //   ),
            // ),

            SizedBox(height: 2.h),

            RichText(
              textAlign: TextAlign.center,
              textScaleFactor: 1.03,
              text: TextSpan(
                text: !isTimeComplete? 'Resend in: ': "Didn't receive a code? ",
                style: GoogleFonts.inter(
                  color: MyColors().black,
                ),
                children: [
                  TextSpan(
                    text: isTimeComplete?'Resend':'00:${NumberFormat("00").format(_duration.inSeconds)}',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      color: isTimeComplete ? MyColors().primaryColor :MyColors().black,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // if (isTimeComplete) {
                        //   if(widget.isFirebase==true){
                        //     AuthController.i.resendFirebaseOTP(context,onSuccess: (){
                        //       // CustomToast().showToast('Success',"We have resend  OTP verification code at your ${phone?'phone number.':'email address.' }",false);
                        //       otp.clear();
                        //       _countDownController.start();
                        //       setState(() {
                        //         isTimeComplete = false;
                        //       });
                        //     });
                        //   } else{
                        //     AuthController.i.resendOTP(context,onSuccess: (){
                        //       CustomToast().showToast('Success',"We have resend  OTP verification code at your ${phone?'phone number.':'email address.' }",false);
                        //       otp.clear();
                        //       _countDownController.start();
                        //       setState(() {
                        //         isTimeComplete = false;
                        //       });
                        //     });
                        //   }
                        // }
                        otp.clear();
                        if (isTimeComplete)
                        {
                          setState(() {
                            resetTimer();
                          });
                        }
                      },
                  ),
                ],
              ),
            ),
            // _circularCountDownTimerWidget(),

            const Spacer(),
            MyButton(title: 'Submit',onTap: (){onSubmit(context);},bgColor: otp.text.length==4?null:MyColors().greyColor  ,),
            SizedBox(height: 0.h),
          ],
        ),
      ),
    );
  }
  onSubmit(context){
    AuthController.i.otp=otp.text;
    AuthController.i.otpValidation(context,firebase:widget.isFirebase??false,fromForgetPassword:widget.fromForgetPassword??false);
  }

  /// #Timer
  void startTimer() {
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
    isTimeComplete = false;
  }
  void stopTimer() {
    setState(() => _countdownTimer!.cancel());
  }
  void resetTimer() {
    stopTimer();
    setState(() => _duration = const Duration(seconds: 59));
    startTimer();
  }
  void setCountDown() {
    const reduceSecondsBy = 1;
    if (mounted) {
      setState(() {
        final seconds = _duration.inSeconds - reduceSecondsBy;
        if (seconds < 0) {
          isTimeComplete = true;
          _countdownTimer!.cancel();
        } else {
          _duration = Duration(seconds: seconds);
        }
      });
    }
  }
/// #Timer
 bool phone =GlobalController.values.loginType.value==LoginType.phone;
}
