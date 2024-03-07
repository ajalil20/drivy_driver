import 'package:drivy_driver/Model/menu_model.dart';
import 'package:drivy_driver/Service/navigation_service.dart';
import 'package:flutter/material.dart';
import '../../../../../Utils/my_colors.dart';
import 'package:sizer/sizer.dart';
import '../../../../Component/custom_text.dart';
import '../../../../Utils/image_path.dart';
import '../../../base_view.dart';

class Availability extends StatelessWidget {
   Availability({super.key});

  List<MenuModel> days =[
    MenuModel(name: 'Monday',description: '07:00 AM - 10:00 PM'),
    MenuModel(name: 'Tuesday',description: '01:00 PM - 08:00 PM'),
    MenuModel(name: 'Wednesday',description: '03:00 PM - 05:00 PM'),
    MenuModel(name: 'Thursday',description: '11:00 AM - 01:00 PM'),
    MenuModel(name: 'Friday',description: '10:00 AM - 08:00 PM'),
    MenuModel(name: 'Saturday',description: '07:00 AM - 07:00 PM'),
    MenuModel(name: 'Sunday',description: '09:00 AM - 06:00 PM'),
  ];

  @override
  Widget build(BuildContext context) {
    return BaseView(
        screenTitle: "Availability",
        showAppBar: true,
        centerTitle: false,
        showBackButton: true,
        resizeBottomInset: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 2.h,),
                ListView.builder(
                  itemCount: days.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuileContext, int index) {
                    return GestureDetector(
                      onTap: (){
                        AppNavigation.navigatorPop(context);
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xffDAE1F1),
                            ),
                            borderRadius: BorderRadius.circular(8),
                            color: MyColors().whiteColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          padding: EdgeInsets.all(12),
                          margin: EdgeInsets.only(bottom: 2.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          MyText(title: days[index].name!,fontWeight: FontWeight.w600,),
                           SizedBox(height: 1.h,),
                          MyText(title: days[index].description!,size: 12,),
                        ],)
                      ),
                    );
                  },
                ),
              ],),
          ),
        )
    );
  }
}
