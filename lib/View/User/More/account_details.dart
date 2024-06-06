import 'package:drivy_driver/Component/custom_buttom.dart';
import 'package:drivy_driver/Component/custom_toast.dart';
import 'package:drivy_driver/Service/navigation_service.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:drivy_driver/Component/custom_empty_data.dart';
import 'package:drivy_driver/Component/custom_padding.dart';
import 'package:drivy_driver/Component/custom_refresh.dart';
import 'package:drivy_driver/Controller/home_controller.dart';
import 'package:drivy_driver/Model/category_product_model.dart';
import 'package:drivy_driver/View/base_view.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_dash/flutter_dash.dart';
import '../../../../Component/custom_image.dart';
import '../../../../Component/custom_text.dart';
import '../../../../Utils/my_colors.dart';
import '../../../Component/custom_textfield.dart';

class BankAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView(
      screenTitle: 'Bank Account Details',
      showAppBar: true,
      centerTitle: false,
      showBackButton: true,
      // resizeBottomInset: false,
      child: GetBuilder<HomeController>(
          builder: (d) {
            return CustomPadding(
              topPadding: 1.h,
              horizontalPadding: 3.w,
              child: Column(
                children: [
                  SizedBox(height: 2.h,),
                  Padding(
                    padding: EdgeInsets.only(left: 2.w, bottom: 1.h),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: MyText(title: "Account Title",
                          size: 13,
                          fontWeight: FontWeight.w600,)),
                  ),
                  MyTextField(
                    width: 90.w,
                    maxLength: 35,
                    hintText: 'Account Title'.tr,
                    onFieldSubmit: (val) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                  ),
                  SizedBox(height: 2.h,),
                  Padding(
                    padding: EdgeInsets.only(left: 2.w, bottom: 1.h),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: MyText(title: "IBAN Number",
                          size: 13,
                          fontWeight: FontWeight.w600,)),
                  ),
                  MyTextField(
                    width: 90.w,
                    hintText: 'IBAN Number'.tr,
                    maxLength: 34,
                    onFieldSubmit: (val) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                  ),
                  Spacer(),
                  MyButton(width: 90.w, title: 'Update Account',onTap: (){AppNavigation.navigatorPop(context); CustomToast().showToast('Success', 'Account Details Updated', false);},),
                  SizedBox(height: 2.h,),
                ],
              ),
            );
          }
      ),
    );
  }
}