import 'package:drivy_driver/Arguments/screen_arguments.dart';
import 'package:drivy_driver/Component/custom_buttom.dart';
import 'package:drivy_driver/Component/custom_image.dart';
import 'package:drivy_driver/Component/custom_toast.dart';
import 'package:drivy_driver/Model/menu_model.dart';
import 'package:drivy_driver/Service/navigation_service.dart';
import 'package:drivy_driver/Utils/app_router_name.dart';
import 'package:flutter/material.dart';
import '../../../../../Utils/my_colors.dart';
import '../../../../../Utils/responsive.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import '../../../../Component/custom_text.dart';
import '../../../../Utils/image_path.dart';
import '../../base_view.dart';
import 'package:google_fonts/google_fonts.dart';

class RateBooking extends StatelessWidget {
  RateBooking({super.key});
  double rate = 0;

  @override
  Widget build(BuildContext context) {
    return BaseView(
        screenTitle: "Rating",
        showAppBar: true,
        centerTitle: false,
        showBackButton: true,
        resizeBottomInset: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(children: [
            Spacer(),
            Image.asset(ImagePath.appLogo,scale: 4,),
            SizedBox(height: 2.h,),
            RichText(
              textAlign: TextAlign.center,
              textScaleFactor: 1.03,
              text: TextSpan(
                text: "Hey Buddy,",
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: MyColors().primaryColor
                ),
                children: [
                  TextSpan(
                    text: '\nEnjoying',
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: MyColors().black
                    ),
                  ),
                  TextSpan(
                    text: ' CAR',
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                    ),
                  ),
                  TextSpan(
                    text: '\nSo far?',
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: MyColors().black
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 3.h,),
            MyText(title: 'Please rate your experience with us',clr: MyColors().greyColor,),
            SizedBox(height: 1.h,),
            Center(
              child: RatingBar(
                initialRating: rate,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                glowColor: Colors.yellow,
                updateOnDrag:true,
                ratingWidget: RatingWidget(
                  full: Icon(Icons.star_rounded,color: Color(0xffFBC400),),
                  half:  Icon(Icons.star_half_rounded,color: Color(0xffFBC400),),
                  empty: Icon(Icons.star_outline_rounded,color: Color(0xffFBC400),),
                ),
                itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                onRatingUpdate: (rating) {
                  rate=rating;
                },
                itemSize:7.w,
              ),
            ),
            Spacer(),
            MyButton(title: 'Submit Rating',onTap: (){
              AppNavigation.navigatorPop(context);
              CustomToast().showToast('Success', 'Your Rating has been sent successfully!', false);
            },bgColor: MyColors().whiteColor,borderColor: MyColors().primaryColor,textColor: MyColors().primaryColor,),
            SizedBox(height: 2.h,),
          ],)
        )
    );
  }
}
