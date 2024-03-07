import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:drivy_user/Arguments/content_argument.dart';
import 'package:drivy_user/Service/navigation_service.dart';
import 'package:drivy_user/Utils/app_router_name.dart';
import 'package:drivy_user/Utils/app_strings.dart';
import 'package:drivy_user/Utils/my_colors.dart';

class CustomTermsCondition extends StatelessWidget {
  const CustomTermsCondition({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      textScaleFactor: 1.03,
      text: TextSpan(
        text: "By signing up, you agree to our ",
        style: GoogleFonts.inter(
          fontWeight: FontWeight.w400,
          fontSize: 13,
          color: MyColors().whiteColor,
        ),
        children: [
          TextSpan(
            text: '\nTerms & Conditions',
            style: GoogleFonts.inter(
              decoration:  TextDecoration.underline,
              fontWeight: FontWeight.w600,
              fontSize: 13,
              decorationThickness: 2,
              color: MyColors().pinkColor,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                AppNavigation.navigateTo(context, AppRouteName.CONTENT_SCREEN,
                    arguments: ContentRoutingArgument(
                        title:'Terms & Conditions',
                        url: 'https://www.google.com/', contentType: ''));
              },
          ),
          TextSpan(
            text: ' and ',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w400,
              fontSize: 13,
              decorationThickness: 2,
              color: MyColors().whiteColor,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
              },
          ),
          TextSpan(
            text: 'Privacy Policy',
            style: GoogleFonts.inter(
              decoration:  TextDecoration.underline,
              fontWeight: FontWeight.w600,
              fontSize: 13,
              decorationThickness: 2,
              color: MyColors().pinkColor,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                AppNavigation.navigateTo(context, AppRouteName.CONTENT_SCREEN,
                    arguments: ContentRoutingArgument(
                        title:'Privacy Policy',
                        url: 'https://www.google.com/', contentType: ''));

                // AppNavigation.navigateTo(context, AppRouteName.CONTENT_SCREEN, arguments: ContentRoutingArgument(
                //     title: AppStrings.PRIVACY_POLICY,
                //     contentType: AppStrings.PRIVACY_POLICY_TYPE));
              },
          ),
        ],
      ),
    );
  }
}
