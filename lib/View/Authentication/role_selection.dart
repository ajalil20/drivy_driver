import 'package:flutter/services.dart';
import 'package:drivy_user/Component/custom_padding.dart';
import 'package:drivy_user/Component/custom_text.dart';
import 'package:drivy_user/Component/title.dart';
import 'package:drivy_user/Controller/global_controller.dart';
import 'package:drivy_user/Service/navigation_service.dart';
import 'package:drivy_user/Utils/app_router_name.dart';
import 'package:drivy_user/Utils/enum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:drivy_user/Utils/my_colors.dart';
import 'package:sizer/sizer.dart';
import 'package:drivy_user/View/Widget/appLogo.dart';
import '../../Component/custom_background_image.dart';
import '../../Component/custom_buttom.dart';
import '../../Utils/app_strings.dart';
import '../../Utils/utils.dart';
import '../base_view.dart';
import 'package:google_fonts/google_fonts.dart';


class RoleSelection extends StatelessWidget {
  GlobalController globalController = Get.put(GlobalController());

  RoleSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: CustomBackgroundImage(
        child: CustomPadding(
          child:  Column(
            children: [
              AppLogo(onTap: (){},),
              SizedBox(
                height: 12.h,
              ),
              ScreenTitle(title: 'Role Selection'),

              SizedBox(
                height: 2.h,
              ),
              MyButton(
                title: "Sign In User",
                onTap: () {onTap(context,u: UserRole.user);},
                bgColor: MyColors().whiteColor,
                textColor:MyColors().black,
              ),
              SizedBox(
                height: 2.h,
              ),
              MyButton(
                title: "Sign In as Seller ",
                onTap: () {onTap(context,u: UserRole.seller);},
              ),
              SizedBox(
                height: 2.h,
              ),
              MyButton(
                title: "Sign In as Influencer",
                onTap: () {onTap(context,u: UserRole.influencer);},
                bgColor: MyColors().purpleLight,
              ),
            ],
          )
        ),
      ),
    );
  }
  onTap(context,{required UserRole u}){
    GlobalController.values.userRole.value = u;
    Utils().saveFCMToken();
    AppNavigation.navigateTo(context,AppRouteName.PRE_LOGIN_SCREEN_ROUTE);
  }
  Future<bool> _onWillPop() async {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop'); return false;
  }
}
